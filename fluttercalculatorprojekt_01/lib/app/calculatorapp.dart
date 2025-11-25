import 'package:flutter/material.dart';
import 'package:fluttercalculatorprojekt_01/ui/pages/calculatorpage.dart';
import 'package:fluttercalculatorprojekt_01/ui/theme/apptheme.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}