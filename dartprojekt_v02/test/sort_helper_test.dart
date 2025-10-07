import 'package:test/test.dart';

import '../bin/dartprojekt_v02.dart';
import '../bin/helpers/sort_helper.dart';

void main() {
  group('herolist', () {
    test('sort hero list based on strength', () {

      final List<Map<String, dynamic>> heroList = [
        {
          "id": 1,
          "name": "Wonder Woman",
          "strength": 95,
          "race": "Amazon",
          "alignment": "Ordningsam"
        },
        {
          "id": 2,
          "name": "Batman",
          "strength": 85,
          "race": "Människa",
          "alignment": "Neutral"
        },
        {
          "id": 3,
          "name": "Cyborg",
          "strength": 90,
          "race": "Android",
          "alignment": "God"
        },
        {
          "id": 4,
          "name": "Superman",
          "strength": 100,
          "race": "Kryptonier",
          "alignment": "God"
        },
      ];

      final sortedHeroes = sortList(heroList, "strength");

      expect(sortedHeroes.first["name"], equals("Superman"));
      expect(sortedHeroes.first["strength"], equals(100));
    });
  });
}