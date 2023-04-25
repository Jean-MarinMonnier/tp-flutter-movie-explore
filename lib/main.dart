import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/favorite_cubit.dart';
import 'package:tp_movie_explorer/blocs/movies_cubit.dart';
import 'package:tp_movie_explorer/repositories/preferences_repository.dart';
import 'package:tp_movie_explorer/repositories/tmdp_repository.dart';
import 'package:tp_movie_explorer/ui/screens/movie_detail_screen.dart';
import 'package:tp_movie_explorer/ui/screens/movies_screen.dart';

import 'blocs/movie_cubit.dart';

void main() {
  TmdbRepository tmdpRepository = TmdbRepository();
  PreferencesRepository preferencesRepository = PreferencesRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MoviesCubit(tmdpRepository)
        ),
        BlocProvider(
          create: (BuildContext context) => MovieCubit(tmdpRepository)
        ),
        BlocProvider(
          create: (BuildContext context) => FavoriteCubit(preferencesRepository)
        ),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().loadFavorites();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoviesScreen(),
      routes: {
        '/detail':(context) => MovieDetailScreen()
      },
    );
  }
}