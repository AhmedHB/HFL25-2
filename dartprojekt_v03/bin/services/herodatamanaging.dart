// services/herodatamanaging.dart

import '../repository/model/heromodel.dart';

abstract class HeroDataManaging {
  Future<int> getNextId();

  Future<bool> saveHero(HeroModel heroMap);

  Future<List<HeroModel>> getHeroList();

  Future<List<HeroModel>> searchHero(String name);
}
