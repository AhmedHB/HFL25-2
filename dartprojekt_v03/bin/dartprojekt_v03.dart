// dartproject_v03.dart

import 'package:args/args.dart';

// helper
import 'helpers/input_helper.dart';
import 'display/hero_display_menue.dart';
import 'display/hero_display_recruit.dart';
import 'display/hero_display_printlist.dart';
import 'display/hero_display_search.dart';

import 'services/herodatamanager.dart';

const String version = '0.0.3';

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
    )..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('''
dartprojekt_v03 – HeroDex 3000!

Usage:
  dart dartprojekt_v03.dart [options]

Alternativ:
${argParser.usage}

Exempel:
  dart dartprojekt_v03.dart --help
  dart dartprojekt_v03.dart --version

När programmet körs:
  - Ser du en meny över möjliga val.
  - 1. Lägg till hjälte – användaren skriver in namn, styrka (int), och ras.
  - 2. Visa hjältar – skriv ut alla hjältar i listan. Sorterat efter styrka.
  - 3. Sök – låt användaren skriva in en bokstav eller ett namn och visa matchande hjältar som börjar på det.
  - 4. Avsluta – stäng programmet.
''');
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
      print('dartprojekt_v03 version: $version');
      return;
    }
    if (results['verbose'] == true) {
      verbose = true;
    }

    HeroDataManager heroManager = HeroDataManager();

    await printMenuHeader();
    int choice = readNumber('Välj ett alternativ (1-4)', 1, 4);
    var res = printAndReturnChoice(choice);

    while (res.run) {
      // Do choice
      switch (res.choice) {
        case 1:
          Map<String, dynamic> newHero = await recruitNewHero();
          heroManager.saveHero(newHero);
          break;

        case 2:
          await printHeroList();
          break;

        case 3:
          await searchHero();
          break;

        default:
          print('Fel: Ogiltigt val. Försök igen.');
          break;
      }

      // Repeat
      await printMenuHeader();
      choice = readNumber('Välj ett alternativ (1-4)', 1, 4);
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
