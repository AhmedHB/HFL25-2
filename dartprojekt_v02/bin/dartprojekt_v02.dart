import 'package:args/args.dart';

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import 'helpers/input_helper.dart';
import 'helpers/sort_helper.dart';

const String version = '0.0.1';

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
dartprojekt_v02 – HeroDex 3000!

Usage:
  dart dartprojekt_v02.dart [options]

Alternativ:
${argParser.usage}

Exempel:
  dart dartprojekt_v02.dart --help
  dart dartprojekt_v02.dart --version

När programmet körs:
  - Ser du en meny över möjliga val.
  - 1. Lägg till hjälte – användaren skriver in namn, styrka (int), och ras.
  - 2. Visa hjältar – skriv ut alla hjältar i listan. Sorterat efter styrka.
  - 3. Sök – låt användaren skriva in en bokstav eller ett namn och visa matchande hjältar som börjar på det.
  - 4. Avsluta – stäng programmet.
''');
}

Future<void> printMenuHeader() async {
  final scriptDir = p.dirname(Platform.script.toFilePath());
  final filePath = p.normalize(p.join(scriptDir, '../resource/superhero_ascii.txt'));
  final file = File(filePath);
  print('################################');
  if (await file.exists()) {
    print(await file.readAsString());
  } else {
    print('File not found at: ${file.path}');
  }
  print('==============================');
  print('        HeroDex 3000!          ');
  print('==============================');
  print('1. Lägg till hjälte');
  print('2. Visa hjältar');
  print('3. Sök hjälte');
  print('4. Avsluta');
  print('==============================');
}

MenueData printAndReturnChoice(int choice){
  bool run = true;
  switch (choice) {
    case 1:
      print('[1] Lägg till hjälte');
      break;
    case 2:
      print('[2] Visa hjältar');
      break;
    case 3:
      print('[3] Sök hjälte');
      break;
    case 4:
      print('[4] Avslutar...');
      run = false;
      break;
    default:
      print('Fel: Ogiltigt val. Försök igen.');
  }

  return MenueData(
            run: run,
            choice: choice,
        );
}

Map<String, dynamic> recruitNewHero(List<Map<String, dynamic>> heroList){
  int id = 1;
  if(heroList.isNotEmpty){
    id = heroList.length + 1;
  }
  String name = readString('\nAnge superhjälte namn', [], false);
  print('Du angav namn: $name');

  const validTypes_gender = [
    'Man',
    'Kvinna',
  ];
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
  String race = readString('Ange ras (Människa/Mutant/Kryptonier/Amazon/Android/Metamänniska/Utomjording)', validTypes_race, true);
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
  String alignment = readString('Ange moraliska inriktning (God/Ond/Neutral/Kaotisk/Ordningsam)',validTypes_alignment,true);
  print('Du angav ras: $alignment');

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();

  return {"id": id, "name": name, "strength": strength, "race": race, "alignment": alignment};
}

void printHeroList(List<Map<String, dynamic>> heroList) {
  print('\n=== HJÄLTAR ===');

  if (heroList.isEmpty) {
    print('Fel: Inga hjältar tillagda ännu i registret.');
  } else {
    heroList = sortList(heroList, "strength");

    heroList.forEach((hero) {
      print(
          '${hero["id"]} - ${hero["name"]} (${hero["race"]}) - Styrka: ${hero["strength"]}, Inriktning: ${hero["alignment"]}');
    });
  }

  print('================\n');

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}

void searchHero(List<Map<String, dynamic>> heroList) {
  if (heroList.isEmpty) {
    print('\nFel: Det finns inga hjältar i registret ännu.\n');
    print('\nTryck [Enter] för att fortsätta...');
    stdin.readLineSync();
    return;
  }

  String query = readString('\nAnge namn eller del av namn att söka efter', [], false);
  query = query.toLowerCase();

  var results = heroList.where(
        (hero) => hero["name"].toString().toLowerCase().startsWith(query),
  ).toList();

  print('\n=== SÖKRESULTAT ===');

  if (results.isEmpty) {
    print('Fel: Ingen hjälte matchade "$query".');
  } else {
    results.forEach((hero) {
      print(
          '${hero["id"]} - ${hero["name"]} (${hero["race"]}) - Styrka: ${hero["strength"]}, Inriktning: ${hero["alignment"]}');
    });
  }

  print('====================\n');

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();
}

//----------------------------------
// Main
//----------------------------------
Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    // Process parsed arguments.
    if (results['help'] == true) {
      printUsage(argParser);
      return;
    }
    if (results['version'] == true) {
      print('dartprojekt_v02 version: $version');
      return;
    }
    if (results['verbose'] == true) {
      verbose = true;
    }

    List<Map<String, dynamic>> heroList = [];

    await printMenuHeader();
    int choice = readNumber('Välj ett alternativ (1-4)', 1, 4);
    var res = printAndReturnChoice(choice);

    while (res.run) {
      // Do choice
      switch (res.choice) {
        case 1:
          Map<String, dynamic> newHero = recruitNewHero(heroList);
          heroList.add(newHero);
          break;

        case 2:
          printHeroList(heroList);
          break;

        case 3:
          searchHero(heroList);
          break;

        default:
          print('Fel: Ogiltigt val. Försök igen.');
          break;
      }

      // Repeat
      await printMenuHeader();
      choice = readNumber('Välj ett alternativ (1-4)', 1,4);
      res = printAndReturnChoice(choice);
    }

    // Debugging output
    if (verbose) {
      print('[DEBUG] Verbose mode active.');
      print('[DEBUG] Register storlek: ${heroList.length}.');
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}

//----------------------------------
// Classes
//----------------------------------
class MenueData {
  bool run;
  int choice;

  MenueData({
    required this.run,
    required this.choice,
  });
}
