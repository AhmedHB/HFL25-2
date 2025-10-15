// display/hero_display_printlist.dart

import 'dart:io';
import 'package:path/path.dart' as p;

import '../services/herodatamanager.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printHeroList() async {
  HeroDataManager heroManager = HeroDataManager();

  print('\n==============================');

  final scriptDir = p.dirname(Platform.script.toFilePath());
  String url = "";
  final resourceFile = '../resource/ascii/superman_flight_ascii.txt';
  final filePath = p.normalize(p.join(scriptDir, resourceFile));
  final file = File(filePath);

  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }

  print('\n==============================');

  print('\n=== HJÄLTAR ==================');
  final List<Map<String, dynamic>> heroList = await heroManager.getHeroList();

  if (heroList.isEmpty) {
    print('Fel: Inga hjältar tillagda ännu i registret.');
  } else {
    heroList.forEach((hero) {
      print(
        '${hero["id"]} - ${hero["name"]} (${hero["race"]}) - Styrka: ${hero["strength"]}, Kön: ${hero["gender"]}, Inriktning: ${hero["alignment"]}',
      );
    });
  }

  print('==============================\n');

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}
