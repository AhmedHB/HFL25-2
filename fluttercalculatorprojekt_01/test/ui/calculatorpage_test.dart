import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:fluttercalculatorprojekt_01/ui/pages/calculatorpage.dart';

void main() {
  Widget createCalculator() {
    return const MaterialApp(
      home: CalculatorPage(),
    );
  }

  testWidgets("Calculator loads correctly", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    // Display
    final display = find.byKey(const Key("display"));
    expect(display, findsOneWidget);
    expect(find.descendant(of: display, matching: find.text("0")), findsOneWidget);

    // Knappar
    expect(find.widgetWithText(TextButton, "0"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "1"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "2"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "3"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "4"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "5"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "6"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "7"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "8"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "9"), findsOneWidget);

    expect(find.widgetWithText(TextButton, "c"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "m"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "mc"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "%"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "÷"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "("), findsOneWidget);
    expect(find.widgetWithText(TextButton, ")"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "×"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "−"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "+"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "+/-"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "="), findsOneWidget);
    expect(find.widgetWithText(TextButton, ","), findsOneWidget);
  });

  testWidgets("Typing works", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    // 2+2 = 4
    await tap("btn_2");
    await tap("btn_+");
    await tap("btn_2");
    await tap("btn_=");

    expect(find.descendant(of: display, matching: find.text("4")), findsOneWidget);
  });

  testWidgets("Error handling works", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    // 1+0 = Error
    await tap("btn_1");
    await tap("btn_÷");
    await tap("btn_0");
    await tap("btn_=");

    expect(find.descendant(of: display, matching: find.text("Error")), findsOneWidget);
  });

  testWidgets("Parentheses work", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    // (2+3)*2 = 10
    await tap("btn_(");
    await tap("btn_2");
    await tap("btn_+");
    await tap("btn_3");
    await tap("btn_)");
    await tap("btn_×");
    await tap("btn_2");
    await tap("btn_=");

    expect(find.descendant(of: display, matching: find.text("10")), findsOneWidget);
  });

  testWidgets("DEL removes last character", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    await tap("btn_9");
    expect(find.descendant(of: display, matching: find.text("9")), findsOneWidget);

    await tap("btn_del");
    expect(find.descendant(of: display, matching: find.text("0")), findsOneWidget);
  });

  testWidgets("Percent converts to decimal", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    await tap("btn_9");
    expect(find.descendant(of: display, matching: find.text("9")), findsOneWidget);

    await tap("btn_%");
    expect(find.descendant(of: display, matching: find.text("0,09")), findsOneWidget);
  });

  testWidgets("Toggle sign works", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    await tap("btn_9");
    expect(find.descendant(of: display, matching: find.text("9")), findsOneWidget);

    await tap("btn_+/-");
    expect(find.descendant(of: display, matching: find.text("-9")), findsOneWidget);
  });

  testWidgets("Memory store and recall", (WidgetTester tester) async {
    await tester.pumpWidget(createCalculator());

    Future<void> tap(String key) async {
      await tester.tap(find.byKey(Key(key)));
      await tester.pump();
    }

    final display = find.byKey(const Key("display"));

    // Spara till minne
    await tap("btn_9");
    await tap("btn_m");
    expect(find.descendant(of: display, matching: find.text("9")), findsOneWidget);

    // Tömma display
    await tap("btn_c");
    expect(find.descendant(of: display, matching: find.text("0")), findsOneWidget);

    // Hämta från minne
    await tap("btn_m");
    expect(find.descendant(of: display, matching: find.text("9")), findsOneWidget);
  });
}
