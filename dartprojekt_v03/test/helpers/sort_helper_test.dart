import 'package:test/test.dart';

import '../../bin/helpers/sort_helper.dart';

void main() {
  group('Sort_helper Tests', () {
    test('sort hero list based on strength', () {

      final List<Map<String, dynamic>> heroList = [
        {
          "id": 1,
          "name": "Wonder Woman",
          "strength": 70,
          "gender": "Kvinna",
          "race": "Amazon",
          "alignment": "Ordningsam"
        },
        {
          "id": 2,
          "name": "Batman",
          "strength": 40,
          "gender": "Man",
          "race": "Människa",
          "alignment": "Neutral"
        },
        {
          "id": 3,
          "name": "Cyborg",
          "strength": 55,
          "gender": "Man",
          "race": "Android",
          "alignment": "God"
        },
        {
          "id": 4,
          "name": "Superman",
          "strength": 95,
          "gender": "Man",
          "race": "Kryptonier",
          "alignment": "God"
        },
      ];

      final sortedHeroes = sortList(heroList, "strength");

      expect(sortedHeroes.first["name"], equals("Superman"));
      expect(sortedHeroes.first["strength"], equals(95));
    });
  });
}