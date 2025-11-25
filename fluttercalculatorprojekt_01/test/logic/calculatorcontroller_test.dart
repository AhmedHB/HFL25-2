import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercalculatorprojekt_01/logic/calculatorcontroller.dart';
import 'package:fluttercalculatorprojekt_01/logic/memorycontroller.dart';

void main() {
  late CalculatorController controller;
  late MemoryController memory;

  setUp(() {
    controller = CalculatorController();
    memory = MemoryController();
  });

  test('adding numbers updates display', () {
    controller.add("1");
    controller.add("2");
    expect(controller.getDisplay(), "12");
  });

  test('operators update sequence', () {
    controller.add("2");
    controller.add("+");
    controller.add("3");
    controller.evaluate();
    expect(controller.getDisplay(), "5");
  });

  test('clear resets state', () {
    controller.add("5");
    controller.clear();
    expect(controller.getDisplay(), "0");
  });

  test('parentheses are allowed', () {
    controller.add("(");
    controller.add("2");
    controller.add("+");
    controller.add("2");
    controller.add(")");
    controller.evaluate();

    expect(controller.getDisplay(), "4");
  });

  test('toggle sign', () {
    controller.add("5");
    controller.toggleSign();
    expect(controller.getDisplay(), "-5");
  });
}
