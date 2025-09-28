# dartprojekt_v01

En enkel kommandoradsbaserad kalkylator skriven i Dart.  
Programmet använder [args](https://pub.dev/packages/args) för flaggparsing och `stdin`/`stdout` för interaktiv inmatning.

---

## Funktioner
- Tar emot två tal (heltal eller decimaltal).
- Stödjer operatorerna `+` och `-` (lätt att utöka till `*` och `/`).
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
│   └── dartprojekt_v01.dart
├── CHANGELOG.md
├── dartprojekt_v01.iml
├── pubspec.lock
├── pubspec.yaml
├── README.md
└── test
    └── calculate_test.dart
```

## Installation
1. Klona projektet eller kopiera koden till en ny Dart-app:
   ```bash
   dart create dartprojekt_v01
   cd dartprojekt_v01

## Användning
2. När du står i katalogen dartprojekt_v01. Kör följande kommando för att köra applikationen.
   ```bash
   dart run bin/dartprojekt_v01.dart

### Exempel på output
```text
Ange första talet: 1
Du angav: 1.0
Ange andra talet: 1
Du angav: 1.0
Ange en operator (+, -): +
Du angav operatorn: +
1.0 + 1.0 = 2.0
```

## Utveckling
3. När du står i katalogen dartprojekt_v01. Kör följande kommando för att köra applikationen i debugg läge.
   ```bash
   dart run bin/dartprojekt_v01.dart --verbose

### Exempel på output
```text
Ange första talet: 1
Du angav: 1.0
Ange andra talet: 1
Du angav: 1.0
Ange en operator (+, -): +
Du angav operatorn: +
1.0 + 1.0 = 2.0
[DEBUG] firstNumber=1.0, secondNumber=1.0, operator=+
```

## Test
4. När du står i katalogen dartprojekt_v01 katalogen. Kör följande kommando för att köra test.
   ```bash
   dart test/calculate_test.dart
   eller
   dart test

### Exempel på output
```text
00:00 +0: calculate adds two numbers

00:00 +1: calculate subtracts two numbers

00:00 +2: calculate throws error for invalid operator

00:00 +3: All tests passed!
```

## Planerade förbättringar
- Stöd för multiplikation och division.
- Möjlighet att mata in fler än två tal.