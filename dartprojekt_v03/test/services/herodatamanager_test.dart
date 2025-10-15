import 'package:test/test.dart';
import '../../bin/services/herodatamanager.dart';

import '../utils/mockherorepository.dart';

void main() {
  group('HeroDataManager Tests', () {
    late HeroDataManager dataManager;
    late MockHeroRepository mockRepo;

    setUp(() {
      mockRepo = MockHeroRepository();
      dataManager = HeroDataManager(repository: mockRepo);
    });

    test('saveHero saves hero successfully', () async {
      final result = await dataManager.saveHero({
        "id": 1,
        "name": "Superman",
        "strength": 95,
        "gender": "Man",
        "race": "Kryptonier",
        "alignment": "God",
      });

      expect(result, isTrue);
      expect(mockRepo.cachedHeroes.length, 0);
      expect((await mockRepo.getHeroes()).length, 1);
    });

    test('getHeroList returns list of heroes sorted by strength', () async {
      await dataManager.saveHero({
        "id": 1,
        "name": "Batman",
        "strength": 40,
        "gender": "Man",
        "race": "Människa",
        "alignment": "Neutral",
      });
      await dataManager.saveHero({
        "id": 2,
        "name": "Wonder Woman",
        "strength": 70,
        "gender": "Kvinna",
        "race": "Amazon",
        "alignment": "Ordningsam"
      });
      await dataManager.saveHero({
        "id": 3,
        "name": "Superman",
        "strength": 95,
        "gender": "Man",
        "race": "Kryptonier",
        "alignment": "God"
      });

      final list = await dataManager.getHeroList();

      expect(list, isNotEmpty);
      expect(list.first['strength'], greaterThan(list.last['strength']));
    });

    test('searchHero finds hero by name', () async {
      await dataManager.saveHero({
        "id": 1,
        "name": "Batman",
        "strength": 40,
        "gender": "Man",
        "race": "Människa",
        "alignment": "Neutral",
      });
      await dataManager.saveHero({
        "id": 2,
        "name": "Wonder Woman",
        "strength": 70,
        "gender": "Kvinna",
        "race": "Amazon",
        "alignment": "Ordningsam"
      });

      final results = await dataManager.searchHero('W');
      expect(results.length, 1);
      expect(results.first['name'], equals('Wonder Woman'));
    });

    test('getNextId returns correct next id', () async {
      expect(await dataManager.getNextId(), equals(1));
      await dataManager.saveHero({
        "id": 1,
        "name": "Superman",
        "strength": 95,
        "gender": "Man",
        "race": "Kryptonier",
        "alignment": "God"
      });
      expect(await dataManager.getNextId(), equals(2));
    });

  });
}
