// lib/repository/model/heromodel.dart

import 'powerstats.dart';
import 'biography.dart';
import 'appearance.dart';
import 'work.dart';
import 'connections.dart';
import 'heroimage.dart';

class HeroModel {
  final String response;
  int id;
  int? externalId;
  final String name;
  final Powerstats powerstats;
  final Biography biography;
  final Appearance appearance;
  final Work work;
  final Connections connections;
  final HeroImage image;

  HeroModel({
    required this.response,
    required this.id,
    this.externalId,
    required this.name,
    required this.powerstats,
    required this.biography,
    required this.appearance,
    required this.work,
    required this.connections,
    required this.image,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      response: json['response'] ?? '',
      id: int.tryParse(json['id'].toString()) ?? 0,
      externalId: int.tryParse(json['externalId'].toString()) ?? 0,
      name: json['name'] ?? '',
      powerstats: Powerstats.fromJson(json['powerstats'] ?? {}),
      biography: Biography.fromJson(json['biography'] ?? {}),
      appearance: Appearance.fromJson(json['appearance'] ?? {}),
      work: Work.fromJson(json['work'] ?? {}),
      connections: Connections.fromJson(json['connections'] ?? {}),
      image: HeroImage.fromJson(json['image'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'id': id,
      'externalId': externalId,
      'name': name,
      'powerstats': powerstats.toJson(),
      'biography': biography.toJson(),
      'appearance': appearance.toJson(),
      'work': work.toJson(),
      'connections': connections.toJson(),
      'image': image.toJson(),
    };
  }

  @override
  String toString() {
    return '''
HeroModel(
  id: $id,
  externalId: $externalId,
  name: $name,
  response: $response,
  powerstats: ${powerstats.toString()},
  biography: ${biography.toString()},
  appearance: ${appearance.toString()},
  work: ${work.toString()},
  connections: ${connections.toString()},
  image: ${image.toString()}
)
''';
  }
}
