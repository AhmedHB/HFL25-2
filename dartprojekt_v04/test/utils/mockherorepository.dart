import '../../lib/repository/model/heromodel.dart';
import '../../lib/repository/herorepository.dart';

// 🧠 A fake repository that just keeps data in memory
class MockHeroRepository extends HeroRepository {
  final List<HeroModel> _storage = [];

  MockHeroRepository() : super(fileName: 'test.json');

  @override
  Future<bool> saveHero(HeroModel hero) async {
    _storage.add(hero);
    return true;
  }

  @override
  Future<List<HeroModel>> getHeroes() async {
    return _storage;
  }

  @override
  Future<HeroModel?> searchHero(String name) async {
    try {
      return _storage.firstWhere((h) => h.name == name);
    } catch (_) {
      return null;
    }
  }
}
