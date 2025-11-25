import 'package:flutter/material.dart';
import 'package:fluttercalculatorprojekt_01/ui/theme/apptheme.dart';

class SpecialButton extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback? onPressed;

  const SpecialButton(
      this.label, {
        super.key,
        this.value,
        this.onPressed,
      });

  bool get isOperator {
    const ops = {
      "c", "m", "mc",
       "%", "+/-"
    };

    return ops.contains(label) || ops.contains(value);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        key: Key("btn_$label"),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor:
          isOperator ? AppTheme.operatorGreen : Colors.white70,
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(label),
      ),
    );
  }
}
