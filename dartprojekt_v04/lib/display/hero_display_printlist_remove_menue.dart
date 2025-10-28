// lib/display/hero_display_printlist_remove_menue.dart

import 'dart:io';
import 'package:path/path.dart' as p;


import 'model/menuedata.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printRemoveMenuHeader() async {
  print('==================================');
  print('        Avskeda          ');
  print('==================================');

  print('1. Ta bort superhjälte/superskurk från lista');
  print('2. Tillbaka till huvudmeny');
  print('==================================');
}

MenueData printRemoveMenueAndReturnChoice(int choice) {
  bool run = true;
  switch (choice) {
    case 1:
      print('[1] Ta bort superhjälte/superskurk från register');
      break;
    case 2:
      print('[2] Tillbaka till huvudmeny');
      break;
    default:
      print('Fel: Ogiltigt val. Försök igen.');
  }

  return MenueData(run: run, choice: choice);
}
