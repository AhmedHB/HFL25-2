// lib/config/app_config.dart
import 'dart:io';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:path/path.dart' as p;

class AppConfig {
  static const String apiBaseUrl = 'https://superheroapi.com/api';
  static const String envFileName = '.env';
  static String? _cachedApiKey;

  static const String heroType = 'Superhjälte';
  static const String villainType = 'Superskurk';

  static const List<String> heroAlignments = [
    'good',
    'lawful good',
    'neutral good',
    'honorable',
    'righteous',
    'just',
    'orderly',
    'heroic',
    'protector',
    'guardian',
    'defender',
    'peacekeeper',
    'virtuous',
    'god',
    'ordningsam',
    'neutral',
  ];

  static const List<String> villainAlignments = [
    'evil',
    'chaotic evil',
    'neutral evil',
    'lawful evil',
    'bad',
    'corrupt',
    'cruel',
    'malicious',
    'malevolent',
    'wicked',
    'tyrannical',
    'dark',
    'ruthless',
    'vengeful',
    'chaotic',
    'lawless',
    'ond',
    'kaotisk',
    'fördärvad',
  ];


  static Future<String> loadApiKey() async {
    if (_cachedApiKey != null) return _cachedApiKey!;

    final envPath = p.join(Directory.current.path, envFileName);
    final envFile = File(envPath);

    if (!await envFile.exists()) {
      throw Exception('Fel: .env fil kan inte hittas på sökvägen: $envPath');
    }

    final env = dotenv.DotEnv(includePlatformEnvironment: true)..load([envPath]);

    final envKey = env['SUPERHERO_API_KEY'];

    if (envKey == null || envKey.trim().isEmpty) {
      throw Exception('Fel: Saknar SUPERHERO_API_KEY in .env file.');
    }

    _cachedApiKey = envKey.trim();
    //print('Loaded API key from .env');
    return _cachedApiKey!;
  }
}
