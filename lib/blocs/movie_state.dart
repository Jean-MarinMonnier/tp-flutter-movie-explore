import 'package:tp_movie_explorer/blocs/movies_state.dart';

import '../models/movie.dart';

class MovieState {
  Movie? movie;
  DataState dataState;

  MovieState({required this.dataState, this.movie});
    factory MovieState.loading() => MovieState(dataState: DataState.loading);
    factory MovieState.loaded(Movie movie) => MovieState(dataState: DataState.loaded, movie: movie);
    factory MovieState.error() => MovieState(dataState: DataState.error);
}