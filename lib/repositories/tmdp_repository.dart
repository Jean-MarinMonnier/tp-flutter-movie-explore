import 'package:dio/dio.dart';

import '../models/movie.dart';

class TmdbRepository {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));
  Future<List<Movie>> fetchPopularMovies() async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'api_key': 'f786d7920751b2397640a333295e76ad',
      'language': 'fr-FR',
      'page': 1,
      'region': 'FR'
    });
// Vérification du code retour (200 = OK)
    if (response.statusCode == 200) {
// Liste à renvoyer
      final List<Movie> movies = [];
// Récupération des données de l'API
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
// Itération sur le résultat
      for (Map<String, dynamic> movieJson in results) {
        final Movie movie = Movie.fromJson(movieJson);
        movies.add(movie);
      }
      return movies;
    } else {
      throw Exception();
    }
  }

  Future<Movie> fetchMovie(int id) async {
    final response = await dio.get('/movie/$id', queryParameters: {
      'api_key': 'f786d7920751b2397640a333295e76ad',
      'language': 'fr-FR',
      'page': 1,
      'region': 'FR'
    });
    final data = response.data as Map<String, dynamic>;
    return Movie.fromJson(data);
  }
}
