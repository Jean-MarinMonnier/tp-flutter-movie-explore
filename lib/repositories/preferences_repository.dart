import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferencesRepository {
  final storage = new FlutterSecureStorage();

  Future<void> saveFavorites(List<int> movies) async {
    // Transformation d'une liste de int en liste de String
    final List<String> list = movies.map((id) => id.toString()).toList();
    // Stockage liste string
    storage.write(key: "movies", value: json.encode(list));
  }

  Future<List<int>> loadFavorites() async {
    List<String>? favoritesIds = json.decode(await storage.read(key: "movies") ?? "");
    if (favoritesIds != null) {
      return favoritesIds.map((id) => int.tryParse(id)).cast<int>().toList();
    }
    return [];
  }

  Future<void> saveToken(String token){
    return storage.write(key: "token", value: token);
  }

  Future<String?> loadToken() { 
    return storage.read(key: "token");
  }
  Future<void> removeToken(){
    return storage.delete(key: "token");
  }
}
