// lib/display/hero_display_local_search.dart

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
Future<void> localSearchHero() async {
  HeroDataManager heroManager = HeroDataManager();

  print('\n==================================');

  final scriptDir = p.dirname(Platform.script.toFilePath());
  String url = "";
  final resourceFile = '../resource/ascii/search_ascii.txt';
  final filePath = p.normalize(p.join(scriptDir, resourceFile));
  final file = File(filePath);

  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }

  print('\n==================================');

  final List<HeroModel> heroes = await heroManager.getHeroList();
  if (heroes.isEmpty) {
    print('\nFel: Det finns inga superhjältar/superskurkar i det lokala registret ännu.\n');
    print('\nTryck [Enter] för att fortsätta...');
    stdin.readLineSync();
    return;
  }

  String query = readString(
    '\nAnge namn eller del av namn att söka efter',
    [],
    false,
  );
  query = query.toLowerCase();
  var results = await heroManager.searchHero(query);

  print('\n=== SÖKRESULTAT ==================');

  if (results.isEmpty) {
    print('Fel: Ingen superhjälte/superskurk matchade "$query".');
  } else {
    for (final hero in results) {
      final race = cleanNull(hero.appearance.race);

      final gender = cleanNull(hero.appearance.gender);

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

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}
