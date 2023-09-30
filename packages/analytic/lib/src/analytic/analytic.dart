import 'package:firebase_analytics/firebase_analytics.dart';

class Analytic {
  final FirebaseAnalytics _firebase;

  Analytic({
    FirebaseAnalytics? instance,
  }) : _firebase = instance ?? FirebaseAnalytics.instance;

  Future<void> logAppOpen() {
    return _firebase.logAppOpen();
  }

  Future<void> logScreenView({
    String? screenClass,
    String? screenName,
  }) {
    return _firebase.logScreenView(
      screenClass: screenClass,
      screenName: screenName,
    );
  }

  Future<void> logEvent(String name, {Map<String, Object?>? parameters}) {
    return _firebase.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
