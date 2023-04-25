import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tp_movie_explorer/blocs/movie_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/movie_state.dart';
import 'package:tp_movie_explorer/blocs/movies_state.dart';

import '../../blocs/favorite_cubit.dart';
import '../../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if(args != null){
      context.read<MovieCubit>().loadMovie(args['id']!);
      return SafeArea(
        child: Scaffold(
          body: BlocBuilder<MovieCubit, MovieState>(builder: (context, MovieState state) {
            Movie? movie = state.movie;
            switch(state.dataState) {
              case DataState.loading:
                return Center(child: CircularProgressIndicator());
              case DataState.loaded:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: ('https://image.tmdb.org/t/p/w500${movie!.posterPath}'),
                            fit: BoxFit.cover,
                            width: double.infinity
                          ),
                          Positioned(
                            left: 15,
                            top: 15,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: (() => Navigator.pop(context)),
                              color: Colors.white,
                              iconSize: 36
                            )
                          ),
                          Positioned(
                            right: 15,
                            top: 15,
                            child: BlocBuilder<FavoriteCubit, List<int>>(builder: ((context, state) {
                              if(state.contains(movie.id))
                                return IconButton(
                                  iconSize: 36,
                                  icon: Icon(Icons.favorite, color: Colors.red),
                                  onPressed: () => context.read<FavoriteCubit>().removeFavorite(movie.id));
                              else
                                return IconButton(
                                  iconSize: 36,
                                  icon: Icon(Icons.favorite_outline, color: Colors.red),
                                  onPressed: () => context.read<FavoriteCubit>().addFavorite(movie.id));
                            })))
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(children: [Text(movie.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]))
                  ]),
                );
              case DataState.error:
                return Center(child: Text("error"));
            }
          },),
        ),
      );
    }
    else
      Navigator.pop(context);
      return Text("Redirection");
  }
}