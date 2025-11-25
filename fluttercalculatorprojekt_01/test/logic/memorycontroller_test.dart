import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercalculatorprojekt_01/logic/memorycontroller.dart';
import 'package:fluttercalculatorprojekt_01/logic/calculatorcontroller.dart';

void main() {
  late MemoryController memory;
  late CalculatorController controller;

  setUp(() {
    memory = MemoryController();
    controller = CalculatorController();
  });

  test('store memory', () {
    controller.add("8");
    controller.memory(memory);
    expect(memory.value, 8);
  });

  test('recall memory', () {
    memory.value = 42;
    controller.memory(memory);
    expect(controller.getDisplay(), "42");
  });

  test('clear memory', () {
    memory.value = 10;
    memory.clear();
    expect(memory.value, isNull);
  });
}
