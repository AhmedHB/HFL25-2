import 'package:test/test.dart';

import '../bin/dartprojekt_v01.dart';

void main() {
  group('calculate', () {
    test('adds two numbers', () {
      expect(calculate(2, 3, '+'), equals(5));
      expect(calculate(2.5, 3.5, '+'), closeTo(6.0, 0.0001));
    });

    test('subtracts two numbers', () {
      expect(calculate(5, 3, '-'), equals(2));
      expect(calculate(10.5, 2.2, '-'), closeTo(8.3, 0.0001));
    });

    test('throws error for invalid operator', () {
      expect(() => calculate(2, 2, '*'), throwsA(isA<ArgumentError>()));
    });
  });
}