import 'package:flutter/material.dart';
import 'package:fluttercalculatorprojekt_01/ui/theme/apptheme.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        key: const Key("btn_del"),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.operatorGreen,
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: const Text("DEL"),
      ),
    );
  }
}
