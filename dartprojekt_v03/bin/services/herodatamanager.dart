// services/herodatamanager.dart

import 'herodatamanaging.dart';
import '../helpers/sort_helper.dart';
import '../repository/herorepository.dart';
import '../repository/model/heromodel.dart';

class HeroDataManager implements HeroDataManaging {
  HeroDataManager._internal({HeroRepository? repository})
      : repository = repository ?? HeroRepository();

  static final HeroDataManager _instance = HeroDataManager._internal();

  factory HeroDataManager({HeroRepository? repository}) {
    if (repository != null) {
      return HeroDataManager._internal(repository: repository);
    }
    return _instance;
  }

  final HeroRepository repository;


  @override
  Future<bool> saveHero(HeroModel heromodel) async {
    try {
      return await repository.saveHero(heromodel);
    } catch (e) {
      print('[HeroDataManager] Error saving hero: $e');
      return false;
    }
  }

  @override
  Future<List<HeroModel>> getHeroList() async {
    final heroes = await repository.getHeroes();
    if (heroes.isNotEmpty) {
      return sortList(heroes, "strength");
    }
    return heroes;
  }

  @override
  Future<List<HeroModel>> searchHero(String name) async {
    final heroes = await repository.getHeroes();

    return heroes
        .where((hero) =>
        hero.name.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }

  @override
  Future<int> getNextId() async {
    final heroes = await repository.getHeroes();
    return heroes.isNotEmpty ? heroes.length + 1 : 1;
  }
}
