// lib/repository/model/heroimage.dart

class HeroImage {
  final String url;

  HeroImage({required this.url});

  factory HeroImage.fromJson(Map<String, dynamic> json) {
    return HeroImage(url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() => {'url': url};

  @override
  String toString() {
    return 'HeroImage(url: $url)';
  }
}
