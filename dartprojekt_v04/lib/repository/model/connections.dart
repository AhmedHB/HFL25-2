// lib/repository/model/connections.dart

class Connections {
  final String groupAffiliation;
  final String relatives;

  Connections({required this.groupAffiliation, required this.relatives});

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['group-affiliation'] ?? '',
      relatives: json['relatives'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'group-affiliation': groupAffiliation,
    'relatives': relatives,
  };

  @override
  String toString() {
    return 'Connections('
        'groupAffiliation: $groupAffiliation, '
        'relatives: $relatives'
        ')';
  }
}
