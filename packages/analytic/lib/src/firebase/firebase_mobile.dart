import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future? setupFirebase(FirebaseOptions option) async {
  HttpClient.enableTimelineLogging = true;

  await Firebase.initializeApp(options: option);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    !kDebugMode,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // To catch errors that happen outside of the Flutter context, install an error listener on the current Isolate:
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);

  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
    !kDebugMode,
  );
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;
  final currentBuild = packageInfo.buildNumber;

  // Not supported on web
  await FirebaseAnalytics.instance.setDefaultEventParameters({
    'ver': 'v$currentVersion-$currentBuild',
    'os': Platform.isAndroid ? 'ADR' : 'iOS',
  });

  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(days: 1),
      ),
    );
    // Only fetch after a delay to prevent an internal bug from occurring
    // See https://github.com/FirebaseExtended/flutterfire/issues/6196
    await Future.delayed(const Duration(milliseconds: 300));
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (e) {
    FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
  }
}
