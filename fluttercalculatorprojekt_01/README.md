# fluttercalculatorprojekt_01

En enkel och fullt funktionell miniräknare byggd i Flutter, med stöd för parenteser, minnesfunktioner, procent, plus/minus, decimaler och testning med flutter_test.

---

## Funktioner
- Grundläggande operatorer: + − × ÷
- Stöd för parenteser
- Procenträkning
- Plus/minus-knapp (+/−)
- Minne (M och MC)
- Clear (C)
- Responsiv layout
---

## Projektstruktur
Trädstruktur för projektet 
```text
tree -I "android|.idea|dart_tool|build|ios|linux|macos|web|windows"
├── analysis_options.yaml
├── fluttercalculatorprojekt_01.iml
├── lib
│ ├── app
│ │ ├── calculatorapp.dart
│ │ └── routes.dart
│ ├── helpers
│ │ └── calculatorLib.dart
│ ├── logic
│ │ ├── calculatorcontroller.dart
│ │ └── memorycontroller.dart
│ ├── main.dart
│ └── ui
│     ├── pages
│     │ └── calculatorpage.dart
│     ├── theme
│     │ └── apptheme.dart
│     └── widgets
│         ├── buttonrow.dart
│         ├── calcbutton.dart
│         ├── deletebutton.dart
│         ├── displaywidget.dart
│         └── specialbutton.dart
├── pubspec.lock
├── pubspec.yaml
├── README.md
└── test
    ├── helpers
    │ └── calculatorLib_test.dart
    ├── logic
    │ ├── calculatorcontroller_test.dart
    │ └── memorycontroller_test.dart
    └── ui
        └── calculatorpage_test.dart
```

## Installation
1. Klona projektet eller kopiera koden till en ny flutter-app:
   ```bash
   flutter create fluttercalculatorprojekt_01
   cd fluttercalculatorprojekt_01

## Användning
2. När du står i katalogen fluttercalculatorprojekt_01. 
   ```bash
   flutter run

## Test
3. När du står i katalogen fluttercalculatorprojekt_01 katalogen. Kör följande kommando för att köra test.
   ```bash
   flutter test --reporter expanded

### Exempel på output
```text
00:00 +0: loading /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart
00:00 +0: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/logic/calculatorcontroller_test.dart: adding numbers updates display
00:00 +1: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/logic/memorycontroller_test.dart: store memory
00:00 +2: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/helpers/calculatorLib_test.dart: evaluateExpression basic operations
00:00 +3: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/helpers/calculatorLib_test.dart: evaluateExpression basic operations
00:00 +4: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/helpers/calculatorLib_test.dart: evaluateExpression basic operations
00:00 +5: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/logic/calculatorcontroller_test.dart: operators update sequence
00:00 +6: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/helpers/calculatorLib_test.dart: evaluateExpression parentheses
00:00 +7: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/logic/calculatorcontroller_test.dart: clear resets state
00:00 +8: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/helpers/calculatorLib_test.dart: evaluateExpression unary operations
00:00 +9: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/helpers/calculatorLib_test.dart: evaluateExpression unary operations
00:00 +10: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Calculator loads correctly
00:00 +11: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Calculator loads correctly
00:00 +12: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Calculator loads correctly
00:00 +13: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Typing works
00:00 +14: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Parentheses work
00:00 +15: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: DEL removes last character
00:00 +16: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Percent converts to decimal
00:00 +17: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Toggle sign works
00:00 +18: /Users/ahmedhb/development/flutter/course/inlamning/HFL25-2/fluttercalculatorprojekt_01/test/ui/calculatorpage_test.dart: Memory store and recall
00:00 +19: All tests passed!

```

## Planerade förbättringar
- Fördjupa mig mer i layout och undersöka GridView
- Laborera med animationer och feedback på kanpptryckningar
- Labba mer med felhantering
- Fler enhetstester