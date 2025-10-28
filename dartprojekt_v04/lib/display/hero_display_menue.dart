// lib/display/hero_display_menue.dart

import 'dart:io';
import 'package:path/path.dart' as p;

import 'model/menuedata.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printMenuHeader() async {
  final scriptDir = p.dirname(Platform.script.toFilePath());
  final filePath = p.normalize(
    p.join(scriptDir, '../resource/ascii/superhero_ascii.txt'),
  );
  final file = File(filePath);
  print('##################################');
  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }
  print('==================================');
  print('        HeroDex 3000!          ');
  print('==================================');
  print('1. Lägg till hjälte/skurk');
  print('2. Visa superhjältar');
  print('3. Visa superskurkar');
  print('4. Sök superhjälte/superskurk lokalt');
  print('5. Sök superhjälte/superskurk externt');
  print('6. Avsluta');
  print('==================================');
}

MenueData printAndReturnChoice(int choice) {
  bool run = true;
  switch (choice) {
    case 1:
      print('[1] Lägg till superhjälte/superskurk manuellt');
      break;
    case 2:
      print('[2] Visa superhjältar');
      break;
    case 3:
      print('[3] Visa superskurkar');
      break;
    case 4:
      print('[4] Sök superhjälte/superskurk lokalt');
      break;
    case 5:
      print('[5] Sök superhjälte/superskurk externt');
      break;
    case 6:
      print('[6] Avslutar...');
      run = false;
      break;
    default:
      print('Fel: Ogiltigt val. Försök igen.');
  }

  return MenueData(run: run, choice: choice);
}
