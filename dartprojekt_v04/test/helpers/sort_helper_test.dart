import 'package:test/test.dart';

import '../../lib/repository/model/heromodel.dart';
import '../../lib/repository/model/powerstats.dart';
import '../../lib/repository/model/biography.dart';
import '../../lib/repository/model/appearance.dart';
import '../../lib/repository/model/work.dart';
import '../../lib/repository/model/connections.dart';
import '../../lib/repository/model/heroimage.dart';

import '../../lib/helpers/sort_helper.dart';

void main() {
  group('Sort_helper Tests', () {

    late List<HeroModel> heroList;

    setUp(() {
      heroList = [
        HeroModel(
          response: 'success',
          id: 1,
          externalId: 0,
          name: 'Wonder Woman',
          powerstats: Powerstats(
            intelligence: '90',
            strength: '70',
            speed: '88',
            durability: '85',
            power: '95',
            combat: '100',
          ),
          biography: Biography(
            fullName: 'Diana Prince',
            alterEgos: 'None',
            aliases: const ['Princess Diana'],
            placeOfBirth: 'Themyscira',
            firstAppearance: 'All Star Comics #8',
            publisher: 'DC Comics',
            alignment: 'Ordningsam',
          ),
          appearance: Appearance(
            gender: 'Kvinna',
            race: 'Amazon',
            height: const ['180 cm'],
            weight: const ['75 kg'],
            eyeColor: 'Blå',
            hairColor: 'Svart',
          ),
          work: Work(occupation: 'Krigare', base: 'Themyscira'),
          connections: Connections(
            groupAffiliation: 'Justice League',
            relatives: 'Hippolyta (mor)',
          ),
          image: HeroImage(url: 'https://example.com/dc/wonderwoman.jpg'),
        ),
        HeroModel(
          response: 'success',
          id: 2,
          externalId: 0,
          name: 'Batman',
          powerstats: Powerstats(
            intelligence: '100',
            strength: '40',
            speed: '29',
            durability: '50',
            power: '47',
            combat: '100',
          ),
          biography: Biography(
            fullName: 'Bruce Wayne',
            alterEgos: 'None',
            aliases: const ['The Dark Knight'],
            placeOfBirth: 'Gotham City',
            firstAppearance: 'Detective Comics #27',
            publisher: 'DC Comics',
            alignment: 'Neutral',
          ),
          appearance: Appearance(
            gender: 'Man',
            race: 'Människa',
            height: const ['188 cm'],
            weight: const ['95 kg'],
            eyeColor: 'Blå',
            hairColor: 'Svart',
          ),
          work: Work(occupation: 'Företagsledare', base: 'Gotham City'),
          connections: Connections(
            groupAffiliation: 'Justice League',
            relatives: 'Alfred Pennyworth',
          ),
          image: HeroImage(url: 'https://example.com/dc/batman.jpg'),
        ),
        HeroModel(
          response: 'success',
          id: 3,
          externalId: 0,
          name: 'Cyborg',
          powerstats: Powerstats(
            intelligence: '75',
            strength: '55',
            speed: '71',
            durability: '85',
            power: '81',
            combat: '64',
          ),
          biography: Biography(
            fullName: 'Victor Stone',
            alterEgos: 'None',
            aliases: const [],
            placeOfBirth: 'Detroit, Michigan',
            firstAppearance: 'DC Comics Presents #26',
            publisher: 'DC Comics',
            alignment: 'God',
          ),
          appearance: Appearance(
            gender: 'Man',
            race: 'Android',
            height: const ['200 cm'],
            weight: const ['173 kg'],
            eyeColor: 'Brun',
            hairColor: 'Svart',
          ),
          work: Work(occupation: 'Superhjälte', base: 'Titans Tower'),
          connections: Connections(
            groupAffiliation: 'Justice League',
            relatives: 'Silas Stone (far)',
          ),
          image: HeroImage(url: 'https://example.com/dc/cyborg.jpg'),
        ),
        HeroModel(
          response: 'success',
          id: 4,
          externalId: 0,
          name: 'Superman',
          powerstats: Powerstats(
            intelligence: '94',
            strength: '95',
            speed: '99',
            durability: '100',
            power: '100',
            combat: '85',
          ),
          biography: Biography(
            fullName: 'Clark Kent',
            alterEgos: 'None',
            aliases: const ['Kal-El'],
            placeOfBirth: 'Krypton',
            firstAppearance: 'Action Comics #1',
            publisher: 'DC Comics',
            alignment: 'God',
          ),
          appearance: Appearance(
            gender: 'Man',
            race: 'Kryptonier',
            height: const ['191 cm'],
            weight: const ['100 kg'],
            eyeColor: 'Blå',
            hairColor: 'Svart',
          ),
          work: Work(occupation: 'Journalist', base: 'Metropolis'),
          connections: Connections(
            groupAffiliation: 'Justice League',
            relatives: 'Lois Lane (fru)',
          ),
          image: HeroImage(url: 'https://example.com/dc/superman.jpg'),
        ),
      ];
    });

    test('sort hero list based on strength', () {
      final sortedHeroes = sortList(heroList, 'strength');

      expect(sortedHeroes.first.name, equals('Superman'));
      expect(sortedHeroes.first.powerstats.strength, equals('95'));
      expect(
        int.parse(sortedHeroes.first.powerstats.strength),
        greaterThan(int.parse(sortedHeroes.last.powerstats.strength)),
      );
    });
  });
}
