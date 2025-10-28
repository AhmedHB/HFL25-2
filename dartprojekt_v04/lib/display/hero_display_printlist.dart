// lib/display/hero_display_printlist.dart

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../helpers/input_helper.dart';
import '../helpers/string_helper.dart';

import '../repository/model/heromodel.dart';
import '../services/herodatamanager.dart';

import 'hero_display_printlist_remove_menue.dart';
import 'hero_display_printlist_remove.dart';

import '../config/app_config.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printHeroList(String heroType) async {
  HeroDataManager heroManager = HeroDataManager();

  print('\n==================================');

  final scriptDir = p.dirname(Platform.script.toFilePath());
  String url = "";
  String resourceFile;
  if (heroType.isNotEmpty && heroType == AppConfig.heroType) {
    resourceFile = '../resource/ascii/superman_flight_ascii.txt';
  } else {
    resourceFile = '../resource/ascii/harley_quinn_ascii.txt';
  }
  final filePath = p.normalize(p.join(scriptDir, resourceFile));
  final file = File(filePath);

  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }

  if (heroType.isNotEmpty && heroType == AppConfig.heroType) {
    print('\n==================================');
  } else {
    print('\n==================================');
  }

  if (heroType.isNotEmpty && heroType == AppConfig.heroType) {
    print('\n=== SUPERHJÄLTAR =================');
  } else {
    print('\n=== SUPERSKURKAR =================');
  }

  final List<HeroModel> heroes;
  if (heroType == AppConfig.heroType) {
    heroes = await heroManager.getHeroListByHeroType(AppConfig.heroType);
  } else {
    heroes = await heroManager.getHeroListByHeroType(AppConfig.villainType);
  }

  if (heroes.isEmpty) {
    if (heroType.isNotEmpty && heroType == AppConfig.heroType) {
      print('Fel: Inga superhjältar tillagda ännu i registret.');
    } else {
      print('Fel: Inga superskurkar tillagda ännu i registret.');
    }
  } else {
    for (final hero in heroes) {
      final race = cleanNull(hero.appearance.race);

      String gender_removed_null = cleanNull(hero.appearance.gender);
      final gender = gender_removed_null == '-' ? 'N/A' : gender_removed_null;

      final alignment = cleanNull(hero.biography.alignment);

      final strength = cleanNull(hero.powerstats.strength);

      print(
        '${hero.id ?? '—'} - ${hero.name} '
        '(${race}) - Styrka: ${strength}, '
        'Kön: $gender, Inriktning: $alignment',
      );
    }
  }

  printRemoveMenuHeader();
  int choice = readNumberWithRange('Välj ett alternativ (1-2)', 1, 2);
  var res = printRemoveMenueAndReturnChoice(choice);

  switch (res.choice) {
    case 1:
      await printHeroListAndRemove(heroType);
      break;

    case 2:
      break;

    default:
      print('Fel: Ogiltigt val. Försök igen.');
      break;
  }
}
