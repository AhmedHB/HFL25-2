// lib/services/superheromanaging.dart

import '../repository/model/heromodel.dart';

abstract class SuperHeroManaging {

  Future<bool> searchHeroExists(String name);

  Future<List<HeroModel>> searchHero(String name);

}