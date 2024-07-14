import 'package:estados_e_navegacao/app/data/models/github_user_model.dart';
import 'package:estados_e_navegacao/app/data/repositories/github_repository.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  final GithubRepository githubRepository;

  final List<GithubUserModel> _users = <GithubUserModel>[].obs;

  List<GithubUserModel> get users => _users;

  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  HomeController({required this.githubRepository});

  getGithubUsers() async {
    _isLoading.value = true;
    final response = await githubRepository.getGithubUsers();
    _users.addAll(response);
    _isLoading.value = false;
  }
}
