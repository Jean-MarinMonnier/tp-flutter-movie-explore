import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/preferences_repository.dart';

class FavoriteCubit extends Cubit<List<int>> {
  FavoriteCubit(this.preferencesRepository) : super([]);

  final PreferencesRepository preferencesRepository;
  void addFavorite(int movieId) {
    emit([...state, movieId]);
    preferencesRepository.saveFavorites(state);
  }
  void removeFavorite(int movieId) {
    state.removeWhere((id) => id == movieId);
    emit([...state]);
  }
  Future<void> loadFavorites() async {
    preferencesRepository.loadFavorites()
    .then((ids) => emit(ids))
    .onError((error, stackTrace) => print(error));
  }
}
