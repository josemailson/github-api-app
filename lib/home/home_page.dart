import 'package:flutter/material.dart';
import 'package:github_api_interface/resources/colors.dart';
import 'package:github_api_interface/resources/text_style.dart';

import 'home_controller.dart';
import 'home_state.dart';

const List<Widget> selection = <Widget>[Text('Repositories'), Text('Starred')];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final textController = TextEditingController();

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.graySuperLight,
        appBar: AppBar(title: const Text('GitHub Profile')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                        child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Digite o username para pesquisar',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColors.blueLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: AppColors.blueVibrant),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: screenWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            homeController.getUserInfo(textController.text);
                          },
                          child: const Text('Buscar')),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                ValueListenableBuilder<HomeState>(
                    valueListenable: homeController.homeState,
                    builder: (context, state, child) {
                      if (state is HomeLoadingState) {
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: LinearProgressIndicator(),
                        ));
                      }
                      if (state is HomeErrorState) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is HomeSuccessState) {
                        return Column(
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    // width: screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                state.homeModel.avatar_url),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.homeModel.name,
                                                      style: AppTextStyles
                                                          .applicationTitle),
                                                  Text(
                                                      'Username: ${state.homeModel.login}',
                                                      style: AppTextStyles
                                                          .example1),
                                                  const Text('Company:',
                                                      style: AppTextStyles
                                                          .example1),
                                                  Text(
                                                      'Location: ${state.homeModel.location}',
                                                      style: AppTextStyles
                                                          .example1),
                                                  const Text('Blog:',
                                                      style: AppTextStyles
                                                          .example1),
                                                  Text(state.homeModel.blog,
                                                      style: AppTextStyles
                                                          .example1),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            const Text('Followers',
                                                style:
                                                    AppTextStyles.filterTitle),
                                            Text('${state.homeModel.followers}',
                                                style: AppTextStyles.example1),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Following',
                                                style:
                                                    AppTextStyles.filterTitle),
                                            Text('${state.homeModel.following}',
                                                style: AppTextStyles.example1),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Gists',
                                                style:
                                                    AppTextStyles.filterTitle),
                                            Text(
                                                '${state.homeModel.public_gists}',
                                                style: AppTextStyles.example1),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text('Repos',
                                                style:
                                                    AppTextStyles.filterTitle),
                                            Text(
                                                '${state.homeModel.public_repos}',
                                                style: AppTextStyles.example1),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Repositories',
                                    style: AppTextStyles.filterTitle)),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 12),
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.repositoryModelList.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: screenWidth * 0.8,
                                    child: Card(
                                      child: SizedBox(
                                        width: screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Repository Name:',
                                                  style:
                                                      AppTextStyles.repoTitle),
                                              Text(
                                                  state
                                                      .repositoryModelList[
                                                          index]
                                                      .full_name,
                                                  style: AppTextStyles
                                                      .description),
                                              const Text('Repository Link:',
                                                  style:
                                                      AppTextStyles.repoTitle),
                                              Text(
                                                  state
                                                      .repositoryModelList[
                                                          index]
                                                      .html_url,
                                                  style: AppTextStyles
                                                      .description),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Starred',
                                    style: AppTextStyles.filterTitle)),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 12),
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.starredModelList.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: screenWidth * 0.8,
                                    child: Card(
                                      child: SizedBox(
                                        width: screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Repository Name:',
                                                  style:
                                                      AppTextStyles.repoTitle),
                                              Text(
                                                  state.starredModelList[index]
                                                      .full_name,
                                                  style: AppTextStyles
                                                      .description),
                                              const Text('Repository Link:',
                                                  style:
                                                      AppTextStyles.repoTitle),
                                              Text(
                                                  state.starredModelList[index]
                                                      .html_url,
                                                  style: AppTextStyles
                                                      .description),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
              ],
            ),
          ),
        ));
  }
}
