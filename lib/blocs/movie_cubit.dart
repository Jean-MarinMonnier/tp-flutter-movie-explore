import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/movie_state.dart';

import '../models/movie.dart';
import '../repositories/tmdp_repository.dart';

class MovieCubit extends Cubit<MovieState> {
  TmdbRepository tmdbRepository;
  MovieCubit(this.tmdbRepository):super(MovieState.loading());

  void loadMovie(int id){
    tmdbRepository.fetchMovie(id)
      .then((movie) => emit(MovieState.loaded(movie)))
      .onError((error, stackTrace) => MovieState.error());
  }
}