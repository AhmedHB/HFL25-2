// lib/services/herodatamanaging.dart

import '../repository/model/heromodel.dart';

abstract class HeroDataManaging {
  Future<int> getNextId();

  Future<bool> saveHero(HeroModel heroMap);

  Future<bool> removeHero(int id);

  Future<List<HeroModel>> getHeroList();

  Future<List<HeroModel>> getHeroListByHeroType(String heroType);

  Future<List<HeroModel>> searchHero(String name);

  Future<List<HeroModel>> searchHeroByExternalId(int? extenralId);
}
