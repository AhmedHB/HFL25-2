import 'package:test/test.dart';
import '../../lib/services/herodatamanager.dart';

import '../../lib/repository/model/heromodel.dart';
import '../../lib/repository/model/powerstats.dart';
import '../../lib/repository/model/biography.dart';
import '../../lib/repository/model/appearance.dart';
import '../../lib/repository/model/work.dart';
import '../../lib/repository/model/connections.dart';
import '../../lib/repository/model/heroimage.dart';

import '../utils/mockherorepository.dart';

void main() {
  group('HeroDataManager Tests', () {
    late HeroDataManager dataManager;
    late MockHeroRepository mockRepo;

    late HeroModel superman;
    late HeroModel batman;
    late HeroModel wonderWoman;

    setUp(() {
      mockRepo = MockHeroRepository();
      dataManager = HeroDataManager(repository: mockRepo);

      superman = HeroModel(
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
      );

      batman = HeroModel(
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
      );

      wonderWoman = HeroModel(
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
      );
    });

    test('saveHero saves hero successfully', () async {
      final result = await dataManager.saveHero(superman);
      expect(result, isTrue);
      expect(mockRepo.cachedHeroes.length, 0);
      expect((await mockRepo.getHeroes()).length, 1);
    });

    test('getHeroList returns heroes sorted by strength', () async {
      await dataManager.saveHero(batman);
      await dataManager.saveHero(wonderWoman);
      await dataManager.saveHero(superman);

      final list = await dataManager.getHeroList();

      expect(list, isNotEmpty);
      expect(
        int.parse(list.first.powerstats.strength),
        greaterThan(int.parse(list.last.powerstats.strength)),
      );
    });

    test('searchHero finds hero by name', () async {
      await dataManager.saveHero(batman);
      await dataManager.saveHero(wonderWoman);

      final results = await dataManager.searchHero('W');
      expect(results.length, 1);
      expect(results.first.name, equals('Wonder Woman'));
    });

    test('getNextId returns correct next id', () async {
      expect(await dataManager.getNextId(), equals(1));
      await dataManager.saveHero(
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
      );
      expect(await dataManager.getNextId(), equals(2));
    });
  });
}
