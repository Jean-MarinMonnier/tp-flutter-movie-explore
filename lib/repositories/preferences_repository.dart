import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  Future<void> saveFavorites(List<int> movies) async {
// Récupération instance sharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
// Transformation d'une liste de int en liste de String
    final List<String> list = movies.map((id) => id.toString()).toList();
// Stockage liste string
    prefs.setStringList('movies', list);
  }

  Future<List<int>> loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritesIds = prefs.getStringList('movies');
    if (favoritesIds != null) {
      return favoritesIds.map((id) => int.tryParse(id)).cast<int>().toList();
    }
    return [];
  }
}
