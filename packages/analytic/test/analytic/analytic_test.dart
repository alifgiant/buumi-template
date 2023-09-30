import 'package:analytic/analytic.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final mockFirebase = MockFirebaseAnalytics();
  final analytic = Analytic(instance: mockFirebase);

  tearDown(() {
    reset(mockFirebase);
  });

  test('logAppOpen is correct', () async {
    // given
    when(() => mockFirebase.logAppOpen()).thenAnswer((_) async {});

    // when
    await analytic.logAppOpen();

    // then
    verify(() => mockFirebase.logAppOpen()).called(1);
  });

  test('logScreenView is correct', () async {
    // given
    const clazzName = 'screenClass';
    const screenName = 'screenName';
    when(
      () => mockFirebase.logScreenView(
        screenClass: any(named: 'screenClass'),
        screenName: any(named: 'screenName'),
      ),
    ).thenAnswer((_) async {});

    // when
    await analytic.logScreenView(
      screenClass: clazzName,
      screenName: screenName,
    );

    // then
    verify(
      () => mockFirebase.logScreenView(
        screenClass: clazzName,
        screenName: screenName,
      ),
    ).called(1);
  });

  test('logEvent is correct', () async {
    // given
    const name = 'Name';
    const param = {'uid': '123qwe'};
    when(
      () => mockFirebase.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});

    // when
    await analytic.logEvent(name, parameters: param);

    // then
    verify(
      () => mockFirebase.logEvent(
        name: name,
        parameters: param,
      ),
    ).called(1);
  });
}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}
