// repository/herorepository.dart

import 'dart:convert';
import 'dart:io';

import 'model/heromodel.dart';

class HeroRepository {
  late final String filePath;

  List<HeroModel> cachedHeroes = [];

  HeroRepository({String? fileName}) {
    fileName ??= 'heroes.json';

    final dir = Directory('${Directory.current.path}/resource/db');

    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    filePath = '${dir.path}/$fileName';

    //print('[HeroRepository] Initialized FileDB at: $filePath');
  }

  Future<bool> saveHero(HeroModel hero) async {
    // Clear cache
    if (cachedHeroes.isNotEmpty) {
      cachedHeroes.clear();
    }

    try {
      final file = File(filePath);
      List<Map<String, dynamic>> heroes = [];

      if (await file.exists()) {
        final content = await file.readAsString();

        if (content.isNotEmpty) {
          final decoded = jsonDecode(content);

          if (decoded is! List) {
            print('[HeroRepository] Invalid JSON format: expected a List');
            return false;
          }

          heroes = decoded
              .map<Map<String, dynamic>>((e) {
                try {
                  return HeroModel.fromJson(e).toJson();
                } catch (err) {
                  print('[HeroRepository] Error parsing hero: $err');
                  return {};
                }
              })
              .where((e) => e.isNotEmpty)
              .toList();
        }
      }

      heroes.add(hero.toJson());

      await file.writeAsString(jsonEncode(heroes), flush: true);
      return true;
    } catch (e, stack) {
      print('[HeroRepository] Error saving hero: $e');
      print(stack);
      return false;
    }
  }

  Future<List<HeroModel>> getHeroes() async {
    // Return cache if not empty
    if (cachedHeroes.isNotEmpty) {
      return cachedHeroes;
    }

    final file = File(filePath);

    if (!await file.exists()) {
      return [];
    }

    try {
      final content = await file.readAsString();
      if (content.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(content);

      if (decoded is! List) {
        print('[HeroRepository] Invalid JSON format: expected a List');
        return [];
      }

      final heroes = decoded
          .map((e) {
            try {
              return HeroModel.fromJson(e);
            } catch (err) {
              print('[HeroRepository] Error parsing hero: $err');
              return null;
            }
          })
          .whereType<HeroModel>()
          .toList();

      // refresh cache
      cachedHeroes = heroes;

      return heroes;
    } on FormatException catch (e) {
      print('[HeroRepository] Invalid JSON: $e');
      return [];
    } on FileSystemException catch (e) {
      print('[HeroRepository] File read error: $e');
      return [];
    } catch (e, stack) {
      print('[HeroRepository] Unexpected error: $e');
      print(stack);
      return [];
    }
  }

  Future<HeroModel?> searchHero(String name) async {
    final heroes = await getHeroes();
    try {
      return heroes.firstWhere((hero) => hero.name == name);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearAll() async {
    cachedHeroes.clear();
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
    print('[HeroRepository] Cleared cache and deleted file.');
  }
}
