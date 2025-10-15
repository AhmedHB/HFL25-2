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
  Future<bool> saveHero(Map<String, dynamic> heroMap) async {
    try {
      final hero = HeroModel.fromJson(heroMap);
      return await repository.saveHero(hero);
    } catch (e) {
      print('[HeroDataManager] Error saving hero: $e');
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getHeroList() async {
    final heroes = await repository.getHeroes();
    final heroMaps = heroes.map((hero) => hero.toJson()).toList();
    if (heroMaps.isNotEmpty) {
      return sortList(heroMaps, "strength");
    }
    return heroMaps;
  }

  @override
  Future<List<Map<String, dynamic>>> searchHero(String name) async {
    final heroes = await repository.getHeroes();
    final heroMaps = heroes.map((hero) => hero.toJson()).toList();
    return heroMaps
        .where((hero) =>
        hero["name"].toString().toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }

  @override
  Future<int> getNextId() async {
    final heroes = await repository.getHeroes();
    return heroes.isNotEmpty ? heroes.length + 1 : 1;
  }
}
