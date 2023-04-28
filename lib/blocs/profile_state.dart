import 'package:tp_movie_explorer/blocs/movies_state.dart';

import '../models/profile.dart';

class ProfileState {
  DataState dataState;
  Profile? profile;

  ProfileState(this.dataState, [this.profile]);
  
  factory ProfileState.loading() => ProfileState(DataState.loading);
  factory ProfileState.loaded(Profile profile) => ProfileState(DataState.loaded, profile);
  factory ProfileState.error() => ProfileState(DataState.error);
}