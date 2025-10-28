// lib/services/herodatamanager.dart

import 'herodatamanaging.dart';
import '../helpers/sort_helper.dart';

import '../repository/herorepository.dart';
import '../repository/model/heromodel.dart';

import '../config/app_config.dart';

class HeroDataManager implements HeroDataManaging {
  final HeroRepository repository;

  HeroDataManager._internal({HeroRepository? repository})
      : repository = repository ?? HeroRepository();

  static final HeroDataManager _instance = HeroDataManager._internal();

  factory HeroDataManager({HeroRepository? repository}) {
    if (repository != null) {
      return HeroDataManager._internal(repository: repository);
    }
    return _instance;
  }

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
  Future<bool> removeHero(int id) async {
    try {
      return await repository.removeHero(id);
    } catch (e) {
      print('[HeroDataManager] Error removing hero: $e');
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
  Future<List<HeroModel>> getHeroListByHeroType(String heroType) async {
    final heroes = await repository.getHeroes();

    List<HeroModel> filteredHeroes;

    if (heroType == AppConfig.heroType) {
      filteredHeroes = heroes.where((hero) {
        final alignment = hero.biography.alignment;
        if (alignment == null || alignment.trim().isEmpty) {
          return true;
        }
        return AppConfig.heroAlignments
            .any((a) => a.toLowerCase() == alignment.toLowerCase());
      }).toList();

    } else if (heroType == AppConfig.villainType) {

      filteredHeroes = heroes.where((hero) {
        final alignment = hero.biography.alignment;
        if (alignment == null || alignment.trim().isEmpty) {
          return true;
        }
        return AppConfig.villainAlignments
            .any((a) => a.toLowerCase() == alignment.toLowerCase());
      }).toList();

    } else {
      throw Exception(
        'Fel: Okänt heroType "$heroType". '
            'Använd "${AppConfig.heroType}" eller "${AppConfig.villainType}".',
      );
    }

    // Sortera efter styrka
    return sortList(filteredHeroes, "strength");
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
  Future<List<HeroModel>> searchHeroByExternalId(int? externalid) async {
    if(externalid ==null)
      return [];

    final heroes = await repository.getHeroes();

    return heroes
        .where((hero) =>
        hero.externalId==externalid)
        .toList();
  }

  @override
  Future<int> getNextId() async {
    final heroes = await repository.getHeroes();
    return heroes.isNotEmpty ? heroes.length + 1 : 1;
  }
}
