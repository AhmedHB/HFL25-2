import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final List<Widget> children;

  const ButtonRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: children),
    );
  }
}
