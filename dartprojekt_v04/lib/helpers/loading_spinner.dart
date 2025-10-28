// lib/helpers/loading_spinner.dart

import 'dart:async';
import 'package:cli_spin/cli_spin.dart';

Future<void> spinner(int duration, String inittext, String text, String completetext) async {
  final spin = CliSpin(text: inittext, spinner: CliSpinners.line)
    ..start();

  try {
    await Future.delayed(Duration(milliseconds: duration ~/ 2));
    spin.color = CliSpinnerColor.yellow;
    spin.text = text;

    await Future.delayed(Duration(milliseconds: duration ~/ 2));

    spin.success(completetext);
  } catch (e) {
    spin.fail('Fel har inträffat: $e');
  }
}
