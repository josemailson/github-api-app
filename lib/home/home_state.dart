import 'package:github_api_interface/home/repository_model.dart';

import 'home_model.dart';

abstract class HomeState {}

class HomeInitialState implements HomeState {}

class HomeLoadingState implements HomeState {}

class HomeSuccessState implements HomeState {
  final HomeModel homeModel;
  final RepositoryModel repositoryModel;
  HomeSuccessState(this.homeModel, this.repositoryModel);
}

class HomeErrorState implements HomeState {
  final String message;
  HomeErrorState(this.message);
}
