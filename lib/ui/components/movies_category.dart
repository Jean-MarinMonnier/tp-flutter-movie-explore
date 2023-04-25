import 'package:flutter/material.dart';

import '../../models/movie.dart';
import 'movie_card.dart';

class MoviesCategory extends StatelessWidget {
  List<Movie> movies;
  String categoryTitle;
  MoviesCategory({required this.movies, required this.categoryTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(categoryTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            itemCount: movies.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => SizedBox(
                              width: 280,
                              child: MovieCard(movie: movies[index])))),
                        ),
                      ],
                    ),
                  );
  }
}