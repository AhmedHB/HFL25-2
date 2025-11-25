import 'package:flutter/material.dart';
import 'package:fluttercalculatorprojekt_01/ui/pages/calculatorpage.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (context) => const CalculatorPage(),
  };
}
