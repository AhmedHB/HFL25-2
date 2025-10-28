// lib/display/hero_display_local_search.dart

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../helpers/input_helper.dart';
import '../helpers/string_helper.dart';

import '../services/superheromanager.dart';

import 'hero_display_external_search_menue.dart';
import 'hero_display_external_search_recruit.dart';

//----------------------------------
// Methods
//----------------------------------
Future<void> externalSearchHero() async {
  final superHeroManager = await SuperHeroManager.create();

  print('\n==================================');

  final scriptDir = p.dirname(Platform.script.toFilePath());
  final resourceFile = '../resource/ascii/search_ascii.txt';
  final filePath = p.normalize(p.join(scriptDir, resourceFile));
  final file = File(filePath);

  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }

  print('\n==================================');
  String query = readString(
    '\nAnge namn eller del av namn att söka efter',
    [],
    false,
  );
  query = query.toLowerCase();
  var results = await superHeroManager.searchHero(query);

  print('\n=== SÖKRESULTAT ==================');

  if (results.isEmpty) {
    print('Fel: Ingen superhjälte/superskurk matchade "$query".');
  } else {
    for (final hero in results) {
      final race = cleanNull(hero.appearance.race);

      String gender_removed_null = cleanNull(hero.appearance.gender);
      final gender = gender_removed_null == '-'? 'N/A' :  gender_removed_null;

      final alignment = cleanNull(hero.biography.alignment);

      final strength = cleanNull(hero.powerstats.strength);

      print(
        '${hero.externalId ?? '—'} - ${hero.name} '
            '(${race}) - Styrka: ${strength}, '
            'Kön: $gender, Inriktning: $alignment',
      );
    }
  }

  printSearchMenuHeader();
  int choice = readNumberWithRange('Välj ett alternativ (1-2)', 1, 2);
  var res = printSearchMenueAndReturnChoice(choice);

  // Do choice
  switch (res.choice) {
    case 1:
      await printHeroSearchListAndRecruit(results);
      break;

    default:
      print('Fel: Ogiltigt val. Försök igen.');
      break;
  }
}
