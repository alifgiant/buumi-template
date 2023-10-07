import 'package:flutter_test/flutter_test.dart';

import 'package:utils/utils.dart';

void main() {
  test('empty string, when toTitleCase will return empty', () {
    final result = ''.toTitleCase();

    expect(result, '');
  });

  test('1 length string, when toTitleCase will uppercased char', () {
    final result = 'a'.toTitleCase();

    expect(result, 'A');
  });

  test('2 length string, when toTitleCase will only uppercase first char', () {
    final result = 'aa'.toTitleCase();

    expect(result, 'Aa');
  });

  test('multiple word, when toTitleCase will only uppercase each first char',
      () {
    final result = 'alif akbar'.toTitleCase();

    expect(result, 'Alif Akbar');
  });

  test('multiple word, when toTitleCase will uppercase each first char', () {
    final result = 'alif akbar'.toTitleCase();

    expect(result, 'Alif Akbar');
  });

  test(
    'uppercased words, when toTitleCase will uppercase each first char and lower the rest',
    () {
      final result = 'ALIF AKBAR'.toTitleCase();

      expect(result, 'Alif Akbar');
    },
  );
}
