import 'package:math_expressions/math_expressions.dart';

double evaluateExpression(String expr) {
  final fixed = _fixImplicitMultiplication(expr);

  Parser p = Parser();
  Expression exp = p.parse(fixed);

  ContextModel cm = ContextModel();
  double result = exp.evaluate(EvaluationType.REAL, cm);

  return result;
}

String _fixImplicitMultiplication(String expr) {
  return expr
      .replaceAllMapped(RegExp(r'(\d)(\()'), (m) => '${m.group(1)}*${m.group(2)}')
      .replaceAllMapped(RegExp(r'(\))(\d)'), (m) => '${m.group(1)}*${m.group(2)}')
      .replaceAllMapped(RegExp(r'([a-zA-Z])(\()'), (m) => '${m.group(1)}*${m.group(2)}');
}