import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tp_movie_explorer/blocs/favorite_cubit.dart';

import '../../models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  Movie movie;
  MovieCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28))),
        elevation: 3,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/detail',
              arguments: {"id": movie.id}),
          child: Row(children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(28)),
                child: CachedNetworkImage(
                  imageUrl:
                      ('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  fit: BoxFit.cover,
                  width: 125,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(children: [
                                  Text(
                                    movie.title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ]),
                                SizedBox(height: 10),
                                Text(movie.id.toString(),
                                    style: TextStyle(color: Colors.grey[400])),
                              ]),
                        ),
                        BlocBuilder<FavoriteCubit, List<int>>(
                            builder: ((context, state) {
                          if (state.contains(movie.id))
                            return Icon(Icons.favorite, color: Colors.red);
                          else
                            return Icon(Icons.favorite_outline,
                                color: Colors.red);
                        }))
                      ],
                    ),
                    SizedBox(height: 5),
                    RatingBar.builder(
                      initialRating: movie.rating / 2,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
