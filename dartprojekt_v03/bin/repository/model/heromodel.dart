// repository/model/heromodel.dart

class HeroModel {
  final int id;
  final String name;
  final String gender;
  final int strength;
  final String race;
  final String alignment;

  HeroModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.strength,
    required this.race,
    required this.alignment,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'gender': gender,
    'strength': strength,
    'race': race,
    'alignment': alignment,
  };

  factory HeroModel.fromJson(Map<String, dynamic> json) => HeroModel(
    id: json['id'],
    name: json['name'],
    gender: json['gender'],
    strength: json['strength'],
    race: json['race'],
    alignment: json['alignment'],
  );
}
