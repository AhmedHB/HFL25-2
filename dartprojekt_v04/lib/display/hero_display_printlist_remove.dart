// lib/display/hero_display_printlist_remove.dart

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../helpers/input_helper.dart';
import '../helpers/string_helper.dart';

import '../repository/model/heromodel.dart';
import '../services/herodatamanager.dart';

import '../config/app_config.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printHeroListAndRemove(String heroType) async {
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

  HeroDataManager heroManager = HeroDataManager();
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

  print('==================================\n');

  String heroId = readString(
    'Välj id att ta bort från lista ovan',
    [],
    false,
  );

  await heroManager.removeHero(int.parse(heroId));

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}
