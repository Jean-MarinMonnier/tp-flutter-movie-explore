import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/blocs/profile_state.dart';
import 'package:tp_movie_explorer/repositories/user_repository.dart';

import '../models/profile.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserRepository userRepository;
  ProfileCubit(this.userRepository): super(ProfileState.loading());

  Future<void> loadProfile() async {
    userRepository.fetchProfile().then((profile) => emit(ProfileState.loaded(profile)));
  }
  Future<void> saveProfile(String firstname, String lastname) async {
    await userRepository.updateProfile(Profile(firstname: firstname, lastname: lastname));
  }
}