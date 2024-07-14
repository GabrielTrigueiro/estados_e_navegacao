import 'package:dio/dio.dart';
import 'package:estados_e_navegacao/app/data/repositories/github_repository.dart';
import 'package:estados_e_navegacao/app/pages/detalhes/detalhes_page.dart';
import 'package:estados_e_navegacao/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(
      githubRepository: GithubRepository(dio: Dio()),
    );
    _controller.getGithubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github users', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        return _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _controller.users.isEmpty
                ? const Center(
                    child: Text('Nenhum usuário encontrado',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)))
                : ListView.separated(
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: _controller.users.length,
                    itemBuilder: (context, index) {
                      final user = _controller.users[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(user.avatarUrl),
                              ),
                            )),
                        title: const Text('Usuário',
                            style: TextStyle(color: Colors.black54)),
                        subtitle: Text(user.login,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Get.to(DetalhesPage(username: user.login,));
                        },
                      );
                    },
                  );
      }),
    );
  }
}
