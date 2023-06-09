import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/movies_state.dart';
import 'package:tp_movie_explorer/blocs/user_cubit.dart';
import 'package:tp_movie_explorer/ui/components/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:tp_movie_explorer/ui/components/movies_category.dart';
import '../../blocs/movies_cubit.dart';
import '../../models/movie.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MoviesCubit>().loadMovies();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(child: Center(child: Text("Movie explorer"))),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text("Profil"),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Se déconnecter"),
              onTap: () => context.read<UserCubit>().logout(),
            ),
          ],)
        ),
        body: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, moviesState){ 
            switch(moviesState.dataState) {
              case DataState.loading :
                return Center(child: CircularProgressIndicator());
              case DataState.loaded :
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        MoviesCategory(movies: moviesState.movies, categoryTitle: "Populaires"),
                        MoviesCategory(movies: moviesState.popularMovies, categoryTitle: "Les mieux notés"),
                      ],
                    ),
                  );
              case DataState.error :
                return Text("Erreur lors du chargement des données.");
            }
        }),
      ),
    );
  }
}