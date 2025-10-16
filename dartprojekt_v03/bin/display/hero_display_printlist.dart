// display/hero_display_printlist.dart

import 'dart:io';
import 'package:path/path.dart' as p;

import '../repository/model/heromodel.dart';
import '../services/herodatamanager.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printHeroList() async {
  HeroDataManager heroManager = HeroDataManager();

  print('\n==================================');

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

  print('\n==================================');

  print('\n=== HJÄLTAR ======================');
  final List<HeroModel> heroes = await heroManager.getHeroList();

  if (heroes.isEmpty) {
    print('Fel: Inga hjältar tillagda ännu i registret.');
  } else {
    for (final hero in heroes) {
      print(
        '${hero.id} - ${hero.name} (${hero.appearance.race}) '
            '- Styrka: ${hero.powerstats.strength}, '
            'Kön: ${hero.appearance.gender}, '
            'Inriktning: ${hero.biography.alignment}',
      );
    }
  }

  print('==================================\n');

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}
