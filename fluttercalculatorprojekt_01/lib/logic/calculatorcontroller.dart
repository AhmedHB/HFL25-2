import 'package:fluttercalculatorprojekt_01/helpers/calculatorLib.dart';

import 'memorycontroller.dart';

class CalculatorController {
  List<String> sequence = [];// Håller alla knapptryckningar som en lista av strängar,
  bool waitingForOperator = false;// True betyder att vi väntar på att användaren ska trycka en operator (+ - * /)
  bool lastWasResult = false;// True om det senaste som visades var ett färdigt resultat (t.ex. efter =)
  bool userTypedNumber = false;// True om användaren aktivt skriver ett tal (siffror/kommatecken). Används för att veta om minnet ska sparas eller inte
  String? lastExpression;// Sparar det senaste uttrycket som räknades ut,

  bool _isNumber(String s) {
    return double.tryParse(s.replaceAll(",", ".")) != null;
  }

  bool _currentNumberHasComma() {
    final expr = sequence.join("");

    int i = expr.length - 1;
    while (i >= 0 && !"()+-*/".contains(expr[i])) {
      i--;
    }

    final number = expr.substring(i + 1);

    return number.contains(",");
  }

  /**
   * Addera till sekvens
   */
  void add(String value) {
    // Tillåt inte multipla komma tecken
    if (value == ",") {
      if (sequence.isEmpty || "+-*/(".contains(sequence.last)) {
        return;
      }
      if (_currentNumberHasComma()) {
        return;
      }
      sequence.add(",");
      userTypedNumber = true;
      lastWasResult = false;
      return;
    }

    // Kontrollera om sekvens endast är error och tillåt bara reset (C)
    if (sequence.length == 1 && sequence[0] == "Error") {
      if (value == "c") {
        clear();
      }
      return;
    }

    // Tillåt inte flera paranterser
    if (value == "(") {
      if (sequence.isNotEmpty && sequence.last == "(") {
        return;
      }

      sequence.add("(");
      return _resetTyping();
    }

    final isNumber = _isNumber(value);

    // Kontrollera att nummer inte börjar på flera nollor
    if (value == "0") {
      if (sequence.length == 1 && sequence.first == "0") {
        return;
      }

      if (sequence.isNotEmpty &&
          sequence.last == "0" &&
          (sequence.length == 1 || "+-*/(".contains(sequence[sequence.length - 2])) ) {
        return;
      }
    }

    if (value == "(") {
      sequence.add(value);
      return _resetTyping();
    }

    if (value == ")") {
      if (sequence.isEmpty) return;
      final last = sequence.last;
      if ("+-*/(".contains(last)) return;

      final open = sequence.where((c) => c == "(").length;
      final close = sequence.where((c) => c == ")").length;
      if (close >= open) return;

      sequence.add(value);
      return _resetTyping();
    }

    if (waitingForOperator && isNumber) {
      return;
    }

    if (isNumber) {
      sequence.add(value);
      userTypedNumber = true;
      lastWasResult = false;
      return;
    }

    if ("+-*/".contains(value)) {
      // Tillåt inte att en operator kan komma efter komma tecken
      if (sequence.isNotEmpty && sequence.last == ",") {
        return;
      }

      if (sequence.isEmpty && value != "-") {
        return;
      }

      if ("+-*/".contains(sequence.last)) {
        sequence.last = value;
      } else {
        sequence.add(value);
      }
      return _resetTyping();
    }

    sequence.add(value);
  }

  /**
   * Ta bort sista tecken
   */
  void deleteLast() {
    if (sequence.isNotEmpty) {
      sequence.removeLast();
    }
    _resetTyping();
  }

  /**
   * Återställ lista
   */
  void clear() {
    sequence = [];
    waitingForOperator = false;
    userTypedNumber = false;
    lastWasResult = false;
    lastExpression = null;
  }

  /**
   * Omvandla procent till decimaler
   */
  void percent() {
    try {
      final expr = sequence.join("").replaceAll(",", ".");
      final value = evaluateExpression(expr) / 100.0;
      setResult(value, expr);
    } catch (_) {
      showError();
    }
  }

  /**
   * Omvanlda tal till positivt / negativt
   */
  void toggleSign() {
    try {
      final expr = sequence.join("").replaceAll(",", ".");
      final value = -evaluateExpression(expr);
      setResult(value, expr);
    } catch (_) {
      showError();
    }
  }

  /**
   * Beräkna utryck
   */
  void evaluate() {
    try {
      // Evaluera inte tomt uttryck
      if (sequence.isEmpty) return;

      // Evaluera inte "Error"
      if (sequence.length == 1 && sequence[0] == "Error") return;

      final last = sequence.last;

      // Evaluera inte om sissta tecken komma eller operator
      if ("+-*/,".contains(last)) {
        return;
      }

      // Evaluera inte om antal paranteser är lika i uttryck
      int open = sequence.where((c) => c == "(").length;
      int close = sequence.where((c) => c == ")").length;

      if (close < open) {
        return;
      }

      final expr = sequence.join("");
      final parsed = expr.replaceAll(",", ".");
      final value = evaluateExpression(parsed);

      // Om evalueringsfel kasta fel
      if (value is double && (value.isInfinite || value.isNaN)) {
        throw FormatException("Math error: $value");
      }

      setResult(value, expr);
    } catch (e, stack) {
      print("Error: $e");
      print("Stack trace: $stack");
      showError();
    }
  }

  /**
   * Skriv ner resultat
   */
  void setResult(double value, String expr) {
    var s = value.toString();
    if (s.endsWith(".0")) s = s.substring(0, s.length - 2);
    s = s.replaceAll(".", ",");

    sequence = [s];
    waitingForOperator = true;
    userTypedNumber = false;
    lastWasResult = true;
    lastExpression = expr;
  }

  /**
   * Skriv ut error och låser så att man måste trycka på C för att återställa
   */
  void showError() {
    sequence = ["Error"];
    waitingForOperator = true;
    userTypedNumber = false;
    lastWasResult = true;
  }

  String getDisplay() {
    return sequence.isEmpty ? "0" : sequence.join("");
  }

  void _resetTyping() {
    waitingForOperator = false;
    userTypedNumber = false;
    lastWasResult = false;
  }

  void memory(MemoryController m) {
    // spara värde
    if ((userTypedNumber || lastWasResult) && sequence.isNotEmpty) {
      final expr = sequence.join("").replaceAll(",", ".");
      final v = double.tryParse(expr);
      if (v != null) {
        m.value = v;
        userTypedNumber = false;
        lastWasResult = false;
        return;
      }
    }

    // hämta sparat värde
    if (m.value != null) {
      var s = m.value.toString();
      if (s.endsWith(".0")) {
        s = s.substring(0, s.length - 2);
      }
      s = s.replaceAll(".", ",");

      sequence = [s];
      waitingForOperator = true;
      userTypedNumber = false;
      lastWasResult = true;
    }
  }
}