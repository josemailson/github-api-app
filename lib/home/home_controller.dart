import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_api_interface/home/repository_model.dart';

import 'home_model.dart';
import 'home_state.dart';

class HomeController {
  final ValueNotifier<HomeState> homeState = ValueNotifier(HomeInitialState());
  final dio = Dio();

  Future<void> getUserInfo(String username) async {
    homeState.value = HomeLoadingState();
    try {
      await Future.delayed(const Duration(seconds: 2));
      final responseUser =
          await dio.get('https://api.github.com/users/$username');
      final responseRepository =
          await dio.get('https://api.github.com/users/$username/repos');
      final homeModel = HomeModel.fromMap(responseUser.data);
      final repositoryModel = RepositoryModel.fromMap(responseRepository.data);
      homeState.value = HomeSuccessState(homeModel, repositoryModel);
    } catch (e) {
      homeState.value = HomeErrorState(e.toString());
    }
  }

  void dispose() {
    homeState.dispose();
  }
}
