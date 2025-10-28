// lib/integration/search/model/searchresponse.dart

import '../../../repository/model/heromodel.dart';

class SearchResponse {
  final String response;
  final String resultsFor;
  final List<HeroModel> results;

  SearchResponse({
    required this.response,
    required this.resultsFor,
    required this.results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      response: json['response'] ?? '',
      resultsFor: json['results-for'] ?? '',
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => HeroModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'response': response,
    'results-for': resultsFor,
    'results': results.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() {
    return 'SearchResponse(response: $response, resultsFor: $resultsFor, resultsCount: ${results.length})';
  }
}
