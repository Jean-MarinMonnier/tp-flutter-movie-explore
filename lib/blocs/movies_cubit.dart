import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/movies_state.dart';

import '../models/movie.dart';
import '../repositories/tmdp_repository.dart';

class MoviesCubit extends Cubit<MoviesState> {
  TmdbRepository tmdbRepository;
  MoviesCubit(this.tmdbRepository) : super(MoviesState.loading());

  void loadMovies(){
    tmdbRepository.fetchPopularMovies()
    .then((movies) => emit(MoviesState.loaded(movies)))
    .onError((error, stackTrace) {
      emit(MoviesState.error());
    });
  }
}