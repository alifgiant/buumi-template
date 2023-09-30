import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

Future? setupFirebase(FirebaseOptions option) async {
  await Firebase.initializeApp(options: option);
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
    !kDebugMode,
  );

  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(days: 1),
      ),
    );
    // Only fetch after a delay to prevent an internal bug from occurring
    // See https://github.com/FirebaseExtended/flutterfire/issues/6196
    // await Future.delayed(const Duration(milliseconds: 300));
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (e) {
    // ignore remote config error
  }
}
