// lib/services/superheromanager.dart

import '../helpers/sort_helper.dart';
import '../repository/model/heromodel.dart';
import '../integration/search/searchintegration.dart';
import '../integration/search/model/searchresponse.dart';
import 'superheromanaging.dart';

class SuperHeroManager implements SuperHeroManaging {
  final SearchIntegration integration;

  SuperHeroManager._(this.integration);

  static Future<SuperHeroManager> create() async {
    final integration = await SearchIntegration.create();
    return SuperHeroManager._(integration);
  }

  @override
  Future<bool> searchHeroExists(String name) async {
    try {
      final integration = await SearchIntegration.create();
      bool response = await integration.searchHeroExists(name);

      return response;
    } catch (e) {
      print('Fel vid sökning av superhjälte/superskurk: $e');
      return false;
    }
  }

  @override
  Future<List<HeroModel>> searchHero(String name) async {
    try {
      final integration = await SearchIntegration.create();
      final SearchResponse response = await integration.searchHero(name);

      if (response.response != 'success' || response.results.isEmpty) {
        print('Inga superhjältar/superskurk som innehåller "$name" hittade.');
        return [];
      }

      final sortedHeroes = sortList(response.results, 'strength');

      return sortedHeroes;
    } catch (e) {
      print('Fel vid sökning av superhjälte/superskurk: $e');
      return [];
    }
  }
}
