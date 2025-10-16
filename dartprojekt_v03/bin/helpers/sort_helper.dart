// helpers/sort_helper.dart

import '../repository/model/heromodel.dart';

//----------------------------------
// Methods
//----------------------------------
List<HeroModel> sortList(List<HeroModel> list, String powerstatfield) {
  if (list.isEmpty) return list;

  list.sort((a, b) {
    dynamic valueA;
    dynamic valueB;

    switch (powerstatfield) {
      case 'strength':
        valueA = int.tryParse(a.powerstats.strength) ?? 0;
        valueB = int.tryParse(b.powerstats.strength) ?? 0;
        break;
      case 'intelligence':
        valueA = int.tryParse(a.powerstats.intelligence) ?? 0;
        valueB = int.tryParse(b.powerstats.intelligence) ?? 0;
        break;
      case 'speed':
        valueA = int.tryParse(a.powerstats.speed) ?? 0;
        valueB = int.tryParse(b.powerstats.speed) ?? 0;
        break;
      default:
        valueA = a.name;
        valueB = b.name;
        break;
    }

    // Sort descending
    return valueB.compareTo(valueA);
  });

  return list;
}
