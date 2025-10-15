// display/hero_display_recruit.dart

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../helpers/input_helper.dart';

import '../services/herodatamanager.dart';

//----------------------------------
// Methods
//----------------------------------
Future<Map<String, dynamic>> recruitNewHero() async {
  HeroDataManager heroManager = HeroDataManager();

  int id = await heroManager.getNextId();

  String name = readString('\nAnge superhjälte namn', [], false);
  print('Du angav namn: $name');

  const validTypes_gender = ['Man', 'Kvinna'];
  String gender = readString('Ange kön (Man/Kvinna)', validTypes_gender, true);
  print('Du angav kön : $gender');

  const validTypes_race = [
    'Människa',
    'Mutant',
    'Kryptonier',
    'Amazon',
    'Android',
    'Metamänniska',
    'Utomjording',
  ];
  String race = readString(
    'Ange ras (Människa/Mutant/Kryptonier/Amazon/Android/Metamänniska/Utomjording)',
    validTypes_race,
    true,
  );
  print('Du angav ras: $race');

  int strength = readNumber('Ange styrka (1-100)', 1, 100);
  print('Du angav styrka: $strength');

  const validTypes_alignment = [
    'God',
    'Ond',
    'Neutral',
    'Kaotisk',
    'Ordningsam',
  ];
  String alignment = readString(
    'Ange moraliska inriktning (God/Ond/Neutral/Kaotisk/Ordningsam)',
    validTypes_alignment,
    true,
  );
  print('Du angav ras: $alignment');

  Map<String, dynamic> hero = {
    "id": id,
    "name": name,
    "gender": gender,
    "strength": strength,
    "race": race,
    "alignment": alignment,
  };

  print('\n==============================');

  final scriptDir = p.dirname(Platform.script.toFilePath());
  String url = "";
  final resourceFile = gender == 'Man'
      ? '../resource/ascii/superman_ascii.txt'
      : '../resource/ascii/wonderwoman_ascii.txt';
  final filePath = p.normalize(p.join(scriptDir, resourceFile));
  final file = File(filePath);

  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }

  print('\n==============================');

  print(
    '\nDu angav hjälte: ID: ${hero["id"]}, Namn: ${hero["name"]}, Kön: ${hero["gender"]}, Ras: ${hero["race"]}, '
    'Styrka: ${hero["strength"]}, Inriktning: ${hero["alignment"]}',
  );

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();

  return hero;
}
