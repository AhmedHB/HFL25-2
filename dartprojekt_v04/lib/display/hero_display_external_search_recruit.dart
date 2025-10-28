// lib/display/hero_display_external_search_recruit.dart

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../helpers/input_helper.dart';
import '../helpers/string_helper.dart';

import '../repository/model/heromodel.dart';
import '../services/herodatamanager.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> printHeroSearchListAndRecruit(List<HeroModel> heroes) async {
  print('\n=== SÖKRESULTAT ==================');

  if (heroes.isEmpty) {
    print('Fel: Inga superhjältar/superskurkar tillagda ännu i registret.');
  } else {
    for (final hero in heroes) {
      final race = cleanNull(hero.appearance.race);

      String gender_removed_null = cleanNull(hero.appearance.gender);
      final gender = gender_removed_null == '-' ? 'N/A' : gender_removed_null;

      final alignment = cleanNull(hero.biography.alignment);

      final strength = cleanNull(hero.powerstats.strength);

      print(
        '${hero.externalId ?? '—'} - ${hero.name} '
        '(${race}) - Styrka: ${strength}, '
        'Kön: $gender, Inriktning: $alignment',
      );
    }
  }

  print('==================================\n');

  String heroId = readString(
    'Välj id att rekrytera från lista ovan',
    [],
    false,
  );

  print('\n==================================');

  HeroModel? foundHero;

  while (foundHero == null) {
    for (final hero in heroes) {
      if (hero.externalId == int.parse(heroId)) {
        foundHero = hero;
        break;
      }
    }

    if (foundHero == null) {
      print('\n=== SÖKRESULTAT ==================');

      if (heroes.isEmpty) {
        print('Fel: Inga superhjältar/superskurkar tillagda ännu i registret.');
      } else {
        for (final hero in heroes) {
          final race = cleanNull(hero.appearance.race);

          String gender_removed_null = cleanNull(hero.appearance.gender);
          final gender = gender_removed_null == '-'
              ? 'N/A'
              : gender_removed_null;

          final alignment = cleanNull(hero.biography.alignment);

          final strength = cleanNull(hero.powerstats.strength);

          print(
            '${hero.externalId ?? '—'} - ${hero.name} '
            '(${race}) - Styrka: ${strength}, '
            'Kön: $gender, Inriktning: $alignment',
          );
        }
      }

      print('==================================\n');

      heroId = readString(
        'Fel id: välj igen rätt id att rekrytera från lista ovan',
        [],
        false,
      );
    }
  }

  if (foundHero != null) {
    final race = cleanNull(foundHero.appearance.race);

    String gender_removed_null = cleanNull(foundHero.appearance.gender);
    final gender = gender_removed_null == '-' ? 'N/A' : gender_removed_null;

    final alignment = cleanNull(foundHero.biography.alignment);

    final strength = cleanNull(foundHero.powerstats.strength);

    print(
      '${foundHero.externalId ?? '—'} - ${foundHero.name} '
      '(${race}) - Styrka: ${strength}, '
      'Kön: $gender, Inriktning: $alignment',
    );

    HeroDataManager heroManager = HeroDataManager();
    final int id = await heroManager.getNextId();

    int? externalId = foundHero.externalId;
    var results = await heroManager.searchHeroByExternalId(externalId);
    if (results.isEmpty) {
      foundHero.id = id;
      await heroManager.saveHero(foundHero);
      print('\nBra val! Nu har den lagts till');
    }else{
      print('\nSuperhjälte/Superskurk existerar redan gör ny sökning och välj igen!');
    }
  }

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}
