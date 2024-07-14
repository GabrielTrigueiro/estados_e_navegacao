

import 'package:estados_e_navegacao/app/data/models/github_user_model.dart';
import 'package:estados_e_navegacao/app/data/repositories/github_repository.dart';
import 'package:get/state_manager.dart';

class DetalhesController extends GetxController {

  final GithubRepository repository;

  GithubUserModel? _githubUser;
  GithubUserModel? get githubUser => _githubUser;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  DetalhesController({required this.repository});

  getGithubUser({required String username}) async {
    _isLoading.value = true;
    final response = await repository.getGithubUser(username: username);
    _githubUser = response;
    _isLoading.value = false;
  }

}
