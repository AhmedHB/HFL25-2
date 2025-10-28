// lib/integration/search/searchintegration.dart

import 'dart:convert';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import 'model/searchresponse.dart';

class SearchIntegration{
  final String accessToken;

  SearchIntegration._(this.accessToken);

  static Future<SearchIntegration> create() async {
    final key = await AppConfig.loadApiKey();
    return SearchIntegration._(key);
  }

  Future<bool> searchHeroExists(String name) async {
    try {
      final response = await http.head(Uri.parse('${AppConfig.apiBaseUrl}/$accessToken/search/$name'));

      return response.statusCode >= 200 && response.statusCode < 400;
    } catch (e) {
      print('Fel vid kontroll av URL: $e');
      return false;
    }
  }

  Future<SearchResponse> searchHero(String name) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/$accessToken/search/$name');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('[SearchIntegration] API-fel: ${response.statusCode}');
      }

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final searchResponse = SearchResponse.fromJson(jsonData);

      for (final hero in searchResponse.results) {
        hero.externalId = int.tryParse(hero.id.toString());
        hero.id = 0;
      }

      return searchResponse;
    } catch (e) {
      print('[SearchIntegration] Fel vid sökning: $e');
      return SearchResponse(response: 'error', resultsFor: name, results: []);
    }
  }
}