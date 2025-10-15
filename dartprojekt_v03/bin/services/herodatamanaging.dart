// services/herodatamanaging.dart

abstract class HeroDataManaging {
  Future<int> getNextId();
  Future<bool> saveHero(Map<String, dynamic> heroMap);
  Future<List<Map<String, dynamic>>> getHeroList();
  Future<List<Map<String, dynamic>>> searchHero(String name);
}
