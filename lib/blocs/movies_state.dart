import '../models/movie.dart';

enum DataState { loading, loaded, error }

class MoviesState {
  late DataState dataState;
  late List<Movie> movies;
  List<Movie> get popularMovies {
    List<Movie> popMovies = movies.map((e) => e).toList();
    popMovies.sort((a, b) => b.rating.compareTo(a.rating));
    return popMovies;
    }

  MoviesState(this.dataState, [this.movies = const []]);
  factory MoviesState.loading() => MoviesState(DataState.loading);
  factory MoviesState.loaded(List<Movie> movies) => MoviesState(DataState.loaded, movies);
  factory MoviesState.error() => MoviesState(DataState.error);
}