import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'home_model.dart';
import 'home_state.dart';

class HomeController {
  final ValueNotifier<HomeState> homeState = ValueNotifier(HomeInitialState());
  final dio = Dio();

  Future<void> getUserInfo(String username) async {
    homeState.value = HomeLoadingState();
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await dio.get('https://api.github.com/users/$username');
      final homeModel = HomeModel.fromMap(response.data);
      homeState.value = HomeSuccessState(homeModel);
    } catch (e) {
      homeState.value = HomeErrorState(e.toString());
    }
  }

  void dispose() {
    homeState.dispose();
  }
}
