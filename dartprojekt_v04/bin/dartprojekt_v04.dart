// dartproject_v04.dart

import 'package:args/args.dart';

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../lib/helpers/input_helper.dart';
import '../lib/helpers/loading_spinner.dart';

import '../lib/config/app_config.dart';
import '../lib/display/hero_display_menue.dart';
import '../lib/display/hero_display_recruit.dart';
import '../lib/display/hero_display_printlist.dart';
import '../lib/display/hero_display_local_search.dart';
import '../lib/display/hero_display_external_search.dart';

import '../lib/repository/model/heromodel.dart';
import '../lib/services/herodatamanager.dart';
import '../lib/services/superheromanager.dart';

const String version = '0.0.4';

//----------------------------------
// Methods
//----------------------------------
ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('''
dartprojekt_v04 – HeroDex 3000!

Usage:
  dart dartprojekt_v04.dart [options]

Alternativ:
${argParser.usage}

Exempel:
  dart dartprojekt_v04.dart --help
  dart dartprojekt_v04.dart --version

När programmet körs:
  - Ser du en meny över möjliga val.
  - 1. Lägg till superhjälte/superskurk – användaren skriver in namn, styrka (int), och ras.
  - 2. Visa superhjältar – skriv ut alla hjältar i listan. Sorterat efter styrka.
  - 3. Visa superskurkar – skriv ut alla skurkar i listan. Sorterat efter styrka.
  - 4. Sök hjälte/skurk lokalt – låt användaren skriva in en bokstav eller ett namn och visa matchande superhjältar/superskurkar som börjar på det.
  - 5. Sök hjälte/skurk externt – låt användaren skriva in en bokstav eller ett namn och visa matchande superhjältar/superskurkar som börjar på det.
  - 6. Avsluta – stäng programmet.
''');
}

Future<void> startupCheckup() async {
  try {
    print('##################################');
    await spinner(
      2000,
      'Initisierar ...',
      'Hämtar config, vänta...',
      'Konfig redo.',
    );
    final apiKey = await AppConfig.loadApiKey();
  } catch (e) {
    print('Fel vid uppstart: $e');

    final envPath = p.join(Directory.current.path, '.env');
    print('\nTips: skapa en .env-fil i projektets rot med t.ex.:');
    print('SUPERHERO_API_KEY=<din-nyckel-här>');
    exit(1);
  }

  try {
    await spinner(
      2000,
      '',
      'Batman förbereder registret över skurkar och hjältar...',
      'Alfred: ‘Sir, JSON-filen är äntligen validerad.',
    );
    final superHeroManager = await SuperHeroManager.create();
    bool res = await superHeroManager.searchHeroExists('Batman');

    if (res == false) {
      throw Exception('Sir, registret svarar inte. Möjligen har Jokern lagt in en bugg igen.');
    }
  } catch (e) {
    print('$e');
    print('\nTips: Ring Alfred. Han vet vad som är felet.');
    exit(1);
  }
}

//----------------------------------
// Main
//----------------------------------
Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    if (results['help'] == true) {
      printUsage(argParser);
      return;
    }
    if (results['version'] == true) {
      print('dartprojekt_v04 version: $version');
      return;
    }
    if (results['verbose'] == true) {
      verbose = true;
    }

    await startupCheckup();

    HeroDataManager heroManager = HeroDataManager();

    await printMenuHeader();
    int choice = readNumberWithRange('Välj ett alternativ (1-6)', 1, 6);
    var res = printAndReturnChoice(choice);

    while (res.run) {
      // Do choice
      switch (res.choice) {
        case 1:
          HeroModel newHero = await recruitNewHero();
          heroManager.saveHero(newHero);
          break;

        case 2:
          await printHeroList(AppConfig.heroType);
          break;

        case 3:
          await printHeroList(AppConfig.villainType);
          break;

        case 4:
          await localSearchHero();
          break;

        case 5:
          await externalSearchHero();
          break;

        default:
          print('Fel: Ogiltigt val. Försök igen.');
          break;
      }

      // Repeat
      await printMenuHeader();
      choice = readNumberWithRange('Välj ett alternativ (1-6)', 1, 6);
      res = printAndReturnChoice(choice);
    }

    // Debugging output
    if (verbose) {
      final heroList = await heroManager.getHeroList();
      print('[DEBUG] Verbose mode active.');
      print('[DEBUG] Register storlek: ${heroList.length}.');
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
