# dartprojekt_v02

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
├── dartprojekt_v02.dart
│   └── helpers
│   ├── input_helper.dart
│   ├── sort_helper.dart
│   ├── string_helper.dart
│   └── validation_helper.dart
├── CHANGELOG.md
├── dartprojekt_v02.iml
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── resource
│   └── superhero_ascii.txt
└── test
    └── sort_helper_test.dart
```

## Installation
1. Klona projektet eller kopiera koden till en ny Dart-app:
   ```bash
   dart create dartprojekt_v02
   cd dartprojekt_v02

## Användning
2. När du står i katalogen dartprojekt_v01. Kör följande kommando för att köra applikationen.
   ```bash
   dart run bin/dartprojekt_v02.dart

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
3. När du står i katalogen dartprojekt_v02. Kör följande kommando för att köra applikationen i debugg läge.
   ```bash
   dart run bin/dartprojekt_v02.dart --verbose

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
4. När du står i katalogen dartprojekt_v02 katalogen. Kör följande kommando för att köra test.
   ```bash
   dart test/sort_helper_test.dart
   eller
   dart test

### Exempel på output
```text
00:00 +0: herolist sort hero list based on strength

00:00 +1: All tests passed!
```

## Planerade förbättringar
- Skapa fler enhetstester
- Möjlighet att spara register så att den är tillgänglig vid nästa start.
- Skapa top 3 lista