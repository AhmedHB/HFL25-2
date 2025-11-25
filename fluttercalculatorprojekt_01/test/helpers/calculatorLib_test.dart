import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercalculatorprojekt_01/helpers/calculatorLib.dart';

void main() {
  group('evaluateExpression', () {
    test('basic operations', () {
      expect(evaluateExpression("1+2"), 3);
      expect(evaluateExpression("2*3"), 6);
      expect(evaluateExpression("10/2"), 5);
      expect(evaluateExpression("5-2"), 3);
    });

    test('parentheses', () {
      expect(evaluateExpression("(2+3)*4"), 20);
      expect(evaluateExpression("2*(3+5*2)"), 26);
      expect(evaluateExpression("((2))"), 2);
    });

    test('unary operations', () {
      expect(evaluateExpression("-5"), -5);
      expect(evaluateExpression("-(3+2)"), -5);
    });

    test('comma formatting (UI style)', () {
      expect(evaluateExpression("1,5+1,5".replaceAll(",", ".")), 3);
    });
  });
}
