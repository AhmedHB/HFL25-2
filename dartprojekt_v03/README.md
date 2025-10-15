# dartprojekt_v03

En enkel register över superhjältar - HeroDex 3000!.  
Programmet använder [args](https://pub.dev/packages/args) för flaggparsing och `stdin`/`stdout` för interaktiv inmatning.

---

## Funktioner
- Printar en ascii bild över superhjälte.
- Visar meny över möjligheter att jobba med superhjälte register
- Flaggar:
    - `--help` / `-h` → visar hjälptext.
    - `--version` → visar version.
    - `--verbose` / `-v` → skriver ut extra information.

---

## Projektstruktur
Trädstruktur för projektet
```text
.
├── analysis_options.yaml
├── bin
│   ├── dartprojekt_v03.dart
│   ├── display
│   │   ├── hero_display_menue.dart
│   │   ├── hero_display_printlist.dart
│   │   ├── hero_display_recruit.dart
│   │   ├── hero_display_search.dart
│   │   └── model
│   │       └── menuedata.dart
│   ├── helpers
│   │   ├── input_helper.dart
│   │   ├── sort_helper.dart
│   │   ├── string_helper.dart
│   │   └── validation_helper.dart
│   ├── repository
│   │   ├── herorepository.dart
│   │   └── model
│   │       └── heromodel.dart
│   └── services
│       ├── herodatamanager.dart
│       └── herodatamanaging.dart
├── CHANGELOG.md
├── dartprojekt_v03.iml
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── resource
│   ├── ascii
│   │   ├── search_ascii.txt
│   │   ├── superhero_ascii.txt
│   │   ├── superman_ascii.txt
│   │   ├── superman_flight_ascii.txt
│   │   └── wonderwoman_ascii.txt
│   └── db
└── test
    ├── helpers
    │   └── sort_helper_test.dart
    ├── services
    │   └── herodatamanager_test.dart
    └── utils
        └── mockherorepository.dart
```

## Installation
1. Klona projektet eller kopiera koden till en ny Dart-app:
   ```bash
   dart create dartprojekt_v03
   cd dartprojekt_v03

## Användning
2. När du står i katalogen dartprojekt_v03. Kör följande kommando för att köra applikationen.
   ```bash
   dart run bin/dartprojekt_v03.dart

### Exempel på output
```text
################################
             .=.,
            ;c =\
          __|  _/
        .'-'-._/-'-._
       /..   ____    \
      /' _  [<_->] )  \
     (  / \--\_>/-/'._ )
      \-;_/\__;__/ _/ _/
       '._}|==o==\{_\/
        /  /-._.--\  \_
       // /   /|   \ \ \
      / | |   | \;  |  \ \
     / /  | :/   \: \   \_\
    /  |  /.'|   /: |    \ \
    |  |  |--| . |--|     \_\
    / _/   \ | : | /___--._) \
   |_(---'-| >-'-| |       '-'
          /_/     \_\
==============================
        HeroDex 3000!          
==============================
1. Lägg till hjälte
2. Visa hjältar
3. Sök hjälte
4. Avsluta
==============================
Välj ett alternativ (1-4): 
```

## Utveckling
3. När du står i katalogen dartprojekt_v03. Kör följande kommando för att köra applikationen i debugg läge.
   ```bash
   dart run bin/dartprojekt_v03.dart --verbose

### Exempel på output
```text
==============================
        HeroDex 3000!          
==============================
1. Lägg till hjälte
2. Visa hjältar
3. Sök hjälte
4. Avsluta
==============================
Välj ett alternativ (1-4): 4
[4] Avslutar...
[DEBUG] Verbose mode active.
[DEBUG] Register storlek: 1.
```
## Test
4. När du står i katalogen dartprojekt_v03 katalogen. Kör följande kommando för att köra test.
   ```bash
   dart test --reporter expanded

### Exempel på output
```text
00:00 +0: loading test/helpers/sort_helper_test.dart
00:00 +0: test/helpers/sort_helper_test.dart: Sort_helper Tests sort hero list based on strength
00:00 +1: test/services/herodatamanager_test.dart: HeroDataManager Tests saveHero saves hero successfully
[HeroRepository] Initialized FileDB at: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/dartprojekt_v03/resource/db/test.json
00:00 +2: test/services/herodatamanager_test.dart: HeroDataManager Tests getHeroList returns list of heroes sorted by strength
[HeroRepository] Initialized FileDB at: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/dartprojekt_v03/resource/db/test.json
00:00 +3: test/services/herodatamanager_test.dart: HeroDataManager Tests searchHero finds hero by name
[HeroRepository] Initialized FileDB at: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/dartprojekt_v03/resource/db/test.json
00:00 +4: test/services/herodatamanager_test.dart: HeroDataManager Tests getNextId returns correct next id
[HeroRepository] Initialized FileDB at: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/dartprojekt_v03/resource/db/test.json
00:00 +5: All tests passed!
```

## Planerade förbättringar
- Titta mer på cache hantering. Just nu har bara skaapt en enkel cache som raderas vid save och och återskapas vid nästa läsning. 
- Undersöka get_it libbet.
- Undersöka möjlighet att utöka meny för exampelvis radering av hjältar.
- Undersöka om att göra så att namn ska vara unikt i listan när man lägger till ny hjälte.