// display/hero_display_recruit.dart

import 'dart:io';
import 'package:path/path.dart' as p;

// helper
import '../helpers/input_helper.dart';

import '../repository/model/heromodel.dart';
import '../repository/model/powerstats.dart';
import '../repository/model/biography.dart';
import '../repository/model/appearance.dart';
import '../repository/model/work.dart';
import '../repository/model/connections.dart';
import '../repository/model/heroimage.dart';

import '../services/herodatamanager.dart';

//----------------------------------
// Methods
//----------------------------------
Future<HeroModel> recruitNewHero() async {
  final heroManager = HeroDataManager();
  final int id = await heroManager.getNextId();

  // Basic Info
  final String name = readString('Ange superhjältens namn', [], false);
  final String fullName = readString(
    'Ange fullständigt namn (t.ex. Clark Kent, Diana Prince, Bruce Wayne)',
    [],
    false,
  );
  final String alterEgos = readString(
    'Ange alter egon (eller lämna tomt) (Clark Kent, osv)',
    [],
    false,
  );

  const validTypes_gender = ['Man', 'Kvinna'];
  final String gender = readString(
    'Ange kön (Man/Kvinna)',
    validTypes_gender,
    true,
  );

  const validTypes_race = [
    'Människa',
    'Mutant',
    'Kryptonier',
    'Amazon',
    'Android',
    'Metamänniska',
    'Utomjording',
    'Okänd',
  ];
  final String race = readString(
    'Ange ras (Människa/Mutant/Kryptonier/Amazon/Android/Metamänniska/Utomjording/Okänd)',
    validTypes_race,
    true,
  );

  // Powerstats
  final int intelligence = readNumber('Ange intelligens (1–100)', 1, 100);
  final int strength = readNumber('Ange styrka (1–100)', 1, 100);
  final int speed = readNumber('Ange hastighet (1–100)', 1, 100);
  final int durability = readNumber('Ange uthållighet (1–100)', 1, 100);
  final int power = readNumber('Ange kraft (1–100)', 1, 100);
  final int combat = readNumber('Ange stridsskicklighet (1–100)', 1, 100);

  // Biography
  final List<String> aliases = readString(
    'Ange alias (kommaseparerade, t.ex. The Man of Steel, Princess Diana, The Dark Knight)',
    [],
    false,
  ).split(',').map((a) => a.trim()).where((a) => a.isNotEmpty).toList();

  final String placeOfBirth = readString(
    'Ange födelseplats (Krypton, Themyscira, Gotham City)',
    [],
    false,
  );
  final String firstAppearance = readString(
    'Ange första framträdande Action Comics #1, All Star Comics #8, Detective Comics #27',
    [],
    false,
  );
  final String publisher = readString(
    'Ange förlag (t.ex. DC Comics, Marvel)',
    [],
    false,
  );

  const validTypes_alignment = [
    'God',
    'Ond',
    'Neutral',
    'Kaotisk',
    'Ordningsam',
  ];
  final String alignment = readString(
    'Ange moraliska inriktning (God/Ond/Neutral/Kaotisk/Ordningsam)',
    validTypes_alignment,
    true,
  );

  // Appearance
  final String heightCm = readString('Ange längd i cm (t.ex. 188)', [], false);
  final String weightKg = readString('Ange vikt i kg (t.ex. 95)', [], false);
  final String eyeColor = readString('Ange ögonfärg', [], false);
  final String hairColor = readString('Ange hårfärg', [], false);

  // Work
  final String occupation = readString(
    'Ange yrke (t.ex. Företagsledare, Journalist, Krigare, Vetenskapsman, Pilot, Soldat, Läkare, Advokat, Ingenjör osv )',
    [],
    false,
  );
  final String base = readString(
    'Ange bas (t.ex. Metropolis, Themyscira, Gotham City)',
    [],
    false,
  );

  // Connections
  final String groupAffiliation = readString(
    'Ange grupptillhörighet (t.ex. Justice League, Avengers)',
    [],
    false,
  );
  final String relatives = readString(
    'Ange släktingar (t.ex. Kara Zor-El (Kusin), Hippolyta (Mor), Alfred Pennyworth (Butler))',
    [],
    false,
  );

  // Image
  final String imageUrlInput = readString(
    'Ange bild-URL (eller lämna tomt för standard)',
    [],
    false,
  );
  final String imageUrl = imageUrlInput.isEmpty
      ? (gender == 'Man'
            ? 'https://example.com/superman.jpg'
            : 'https://example.com/wonderwoman.jpg')
      : imageUrlInput;

  // Create heromodel
  final hero = HeroModel(
    response: 'success',
    id: id,
    name: name,
    powerstats: Powerstats(
      intelligence: intelligence.toString(),
      strength: strength.toString(),
      speed: speed.toString(),
      durability: durability.toString(),
      power: power.toString(),
      combat: combat.toString(),
    ),
    biography: Biography(
      fullName: fullName,
      alterEgos: alterEgos,
      aliases: aliases,
      placeOfBirth: placeOfBirth,
      firstAppearance: firstAppearance,
      publisher: publisher,
      alignment: alignment,
    ),
    appearance: Appearance(
      gender: gender,
      race: race,
      height: ['${heightCm} cm'],
      weight: ['${weightKg} kg'],
      eyeColor: eyeColor,
      hairColor: hairColor,
    ),
    work: Work(occupation: occupation, base: base),
    connections: Connections(
      groupAffiliation: groupAffiliation,
      relatives: relatives,
    ),
    image: HeroImage(url: imageUrl),
  );

  print('\n==================================');

  // ASCII art preview
  final scriptDir = p.dirname(Platform.script.toFilePath());
  final resourceFile = gender == 'Man'
      ? '../resource/ascii/superman_ascii.txt'
      : '../resource/ascii/wonderwoman_ascii.txt';
  final filePath = p.normalize(p.join(scriptDir, resourceFile));
  final file = File(filePath);
  if (await file.exists()) {
    print(await file.readAsString());
  }

  print('\n==================================');

  print('\n${hero.toString()}\n');

  print('\nTryck [Enter] för att fortsätta...');
  stdin.readLineSync();

  return hero;
}
