import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tp_movie_explorer/repositories/preferences_repository.dart';

import '../models/profile.dart';
import '../models/token.dart';

class UserRepository {
  PreferencesRepository preferencesRepository;
  Token? token;
  final _dio =
      Dio(BaseOptions(baseUrl: 'https://movies-backend-ykdv.onrender.com'));

  UserRepository(this.preferencesRepository);

  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.post('/users/login', data: {
        "username": username,
        "password": password
      }).onError((error, stackTrace) => throw Exception(error));
      if (response.statusCode == 200) {
        print("logged in");
        token = Token.fromJson(response.data);
        preferencesRepository.saveToken(json.encode(token));
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void logout() {
    if (token != null) {
      preferencesRepository.removeToken();
    }
  }

  Future<bool> signup(String username, String password) async {
    final response = await _dio.post('/users/signup', data: {
      "username": username,
      "password": password
    }).onError((error, stackTrace) => throw Exception(error));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<bool> init() async {
    String? strToken = await preferencesRepository.loadToken();
    if (strToken != null) {
      token = json.decode(strToken);
      return true;
    }
    return false;
  }

  void rateMovie(int movieId, double rating) async {
    try {
      final response = await _dio.post('/rating',
          options: Options(
              headers: {"Authorization": "Bearer ${token?.accessToken}"}),
          data: {"movieId": movieId, "rating": rating});
      if (response.statusCode == 200) {
        print("Film noter avec succès");
        return;
      } else if (response.statusCode == 403) {
        if (token == null) {
          throw Exception("Token null");
        } else {
          await _refreshToken();
          rateMovie(movieId, rating);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final response = await _dio.post('/users/refreshToken',
          data: {"refresh_token": token?.refreshToken});
      if (response.statusCode == 200) {
        token = Token.fromJson(response.data);
        preferencesRepository.saveToken(json.encode(token));
      }
    } catch (e) {
      token = null;
    }
  }

  Future<void> updateProfile(Profile profile) async {
    final response = await _dio.post('/profile',
    data: {
      "firstname" : profile.firstname,
      "lastname": profile.lastname
    },
    options: Options(
      headers: {
        "Authorization": "Bearer ${token?.accessToken}"
      }
    ));

    if(response.statusCode == 200) {
      print("Ajout profile");
      return;
    }
    else if (response.statusCode == 401){
        if (token == null) {
          throw Exception("Token null");
        } else {
          await _refreshToken();
          updateProfile(profile);
        }
    }
  }
  Future<Profile> fetchProfile() async {
    final response = await _dio.get('/profile', options: Options(
      headers: {
        "Authorization": "Bearer ${token?.accessToken}"
      }
    ));
    return Profile.fromJson(response.data);
  }
}
