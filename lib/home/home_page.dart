import 'package:flutter/material.dart';

import 'home_controller.dart';
import 'home_state.dart';

const List<Widget> selection = <Widget>[Text('Repositories'), Text('Starred')];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> _selected = <bool>[true, false];
  final homeController = HomeController();
  final textController = TextEditingController();

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  void doSomething() {
    print('botão apertado');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text('GitHub Profile')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  Form(
                      child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Digite o username para pesquisar',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.blueAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.greenAccent),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              // width: screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        state.homeModel.avatar_url),
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
                                            Text(state.homeModel.name),
                                            Text(
                                                'Username: ${state.homeModel.login}'),
                                            const Text('Company:'),
                                            Text(
                                                'Location: ${state.homeModel.location}'),
                                            const Text('Blog:'),
                                            Text(state.homeModel.blog),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text('Followers'),
                                    Text('${state.homeModel.followers}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Following'),
                                    Text('${state.homeModel.following}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Gists'),
                                    Text('${state.homeModel.public_gists}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Repos'),
                                    Text('${state.homeModel.public_repos}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ToggleButtons(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 100.0,
                              ),
                              onPressed: (int index) {
                                setState(() {
                                  _selected[index] = !_selected[index];
                                });
                              },
                              isSelected: _selected,
                              children: selection,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
            ],
          ),
        ));
  }
}
