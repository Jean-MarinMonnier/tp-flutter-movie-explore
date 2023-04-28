import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_movie_explorer/repositories/user_repository.dart';

class UserCubit extends Cubit<bool> {
  UserRepository userRepository;
  UserCubit(this.userRepository) : super(false);

  void login(String username, String password) async {
    userRepository.login(username, password)
      .then((value) => emit(true))
      .onError((error, stackTrace) {
        print(error);
        if(state){
          emit(false);
        }
      });
  }

  Future<bool> signup(String username, String password) async {
    return await userRepository.signup(username, password)
    .onError((error, stackTrace) => throw Exception("Erreur lors de la création"));
  }

  void init() {
    userRepository.init().then((hasToken) => emit(hasToken));
  }

  void logout(){
    emit(false);
  }

  void rateMovie(int movieId, double rating) {
    try {
      userRepository.rateMovie(movieId, rating);
    }
    catch(e){
      throw Exception(e);
    }
  }
}
