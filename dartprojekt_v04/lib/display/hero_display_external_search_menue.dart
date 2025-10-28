// lib/display/hero_display_external_search_menue.dart

import 'model/menuedata.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printSearchMenuHeader() async {
  print('==================================');
  print('        Rekrytera          ');
  print('==================================');

  print('1. Addera superhjälte/superskurk från lista');
  print('2. Tillbaka till huvudmeny');
  print('==================================');
}

MenueData printSearchMenueAndReturnChoice(int choice) {
  bool run = true;
  switch (choice) {
    case 1:
      print('[1] Klona superhjälte/superskurk från sökning resultat');
      break;
    case 2:
      print('[2] Tillbaka till huvudmeny');
      break;
    default:
      print('Fel: Ogiltigt val. Försök igen.');
  }

  return MenueData(run: run, choice: choice);
}
