# dartprojekt_v04

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
│ └── dartprojekt_v04.dart
├── CHANGELOG.md
├── dartprojekt_v04.iml
├── lib
│ ├── config
│ │ └── app_config.dart
│ ├── display
│ │ ├── hero_display_external_search_menue.dart
│ │ ├── hero_display_external_search_recruit.dart
│ │ ├── hero_display_external_search.dart
│ │ ├── hero_display_local_search.dart
│ │ ├── hero_display_menue.dart
│ │ ├── hero_display_printlist_remove_menue.dart
│ │ ├── hero_display_printlist_remove.dart
│ │ ├── hero_display_printlist.dart
│ │ ├── hero_display_recruit.dart
│ │ └── model
│ │     └── menuedata.dart
│ ├── helpers
│ │ ├── input_helper.dart
│ │ ├── loading_spinner.dart
│ │ ├── sort_helper.dart
│ │ ├── string_helper.dart
│ │ └── validation_helper.dart
│ ├── integration
│ │ └── search
│ │     ├── model
│ │     │ └── searchresponse.dart
│ │     └── searchintegration.dart
│ ├── repository
│ │ ├── herorepository.dart
│ │ └── model
│ │     ├── appearance.dart
│ │     ├── biography.dart
│ │     ├── connections.dart
│ │     ├── heroimage.dart
│ │     ├── heromodel.dart
│ │     ├── powerstats.dart
│ │     └── work.dart
│ └── services
│     ├── herodatamanager.dart
│     ├── herodatamanaging.dart
│     ├── superheromanager.dart
│     └── superheromanaging.dart
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── resource
│ ├── ascii
│ │ ├── harley_quinn_ascii.txt
│ │ ├── search_ascii.txt
│ │ ├── superhero_ascii.txt
│ │ ├── superman_ascii.txt
│ │ ├── superman_flight_ascii.txt
│ │ └── wonderwoman_ascii.txt
│ └── db
│     └── heroes.json
└── test
    ├── helpers
    │ └── sort_helper_test.dart
    ├── services
    │ └── herodatamanager_test.dart
    └── utils
        └── mockherorepository.dart

```

## Installation
1. Klona projektet eller kopiera koden till en ny Dart-app:
   ```bash
   dart create dartprojekt_v04
   cd dartprojekt_v04

## Användning
2. När du står i katalogen dartprojekt_v04. Så behöver du skapa en .env fill med följande innehåll:
   SUPERHERO_API_KEY=<din-nyckel-här>
   Därefter kör följande kommando för att köra applikationen.
   ```bash
   dart pub get
   dart run bin/dartprojekt_v04.dart

### Exempel på output
```text
##################################
✔ Konfig redo.
✔ Alfred: ‘Sir, JSON-filen är äntligen validerad.
##################################
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
==================================
        HeroDex 3000!          
==================================
1. Lägg till hjälte/skurk
2. Visa superhjältar
3. Visa superskurkar
4. Sök superhjälte/superskurk lokalt
5. Sök superhjälte/superskurk externt
6. Avsluta
================================== 
```

## Utveckling
3. När du står i katalogen dartprojekt_v04. Kör följande kommando för att köra applikationen i debugg läge.
   ```bash
   dart run bin/dartprojekt_v04.dart --verbose

### Exempel på output
```text
##################################
✔ Konfig redo.
✔ Alfred: ‘Sir, JSON-filen är äntligen validerad.
##################################
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
==================================
        HeroDex 3000!          
==================================
1. Lägg till hjälte/skurk
2. Visa superhjältar
3. Visa superskurkar
4. Sök superhjälte/superskurk lokalt
5. Sök superhjälte/superskurk externt
6. Avsluta
==================================
Välj ett alternativ (1-6): 6
[6] Avslutar...
[DEBUG] Verbose mode active.
[DEBUG] Register storlek: 7.
```
## Test
4. När du står i katalogen dartprojekt_v04 katalogen. Kör följande kommando för att köra test.
   ```bash
   dart test --reporter expanded

### Exempel på output
```text
00:00 +0: loading test/helpers/sort_helper_test.dart
00:00 +0: test/helpers/sort_helper_test.dart: Sort_helper Tests sort hero list based on strength
00:00 +1: test/services/herodatamanager_test.dart: HeroDataManager Tests saveHero saves hero successfully
00:00 +2: test/services/herodatamanager_test.dart: HeroDataManager Tests getHeroList returns heroes sorted by strength
00:00 +3: test/services/herodatamanager_test.dart: HeroDataManager Tests searchHero finds hero by name
00:00 +4: test/services/herodatamanager_test.dart: HeroDataManager Tests getNextId returns correct next id
00:00 +5: All tests passed!
```

## Planerade förbättringar
- Undersöka animationer
- Undersöka ljud