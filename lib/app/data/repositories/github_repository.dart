import 'package:dio/dio.dart';
import 'package:estados_e_navegacao/app/data/models/github_user_model.dart';

class GithubRepository {
  final Dio dio;

  GithubRepository({required this.dio});

  Future<List<GithubUserModel>> getGithubUsers() async {
    final result = await dio.get('https://api.github.com/users');

    if (result.statusCode == 200) {
      final List<GithubUserModel> users = [];

      // preenhce o novo o usuario com o map do model
      result.data.map((item) => users.add(GithubUserModel.fromMap(item))).toList();

      return users;
    }

    else if (result.statusCode == 401) {
      throw Exception('Não autorizado');
    }

    else if (result.statusCode == 403) {
      throw Exception('Forbidden');
    }

    else {
      throw Exception('Erro desconhecido');
    }
  }

  Future<GithubUserModel> getGithubUser({required String username}) async {
    final result = await dio.get('https://api.github.com/users/$username');

    late GithubUserModel githubuser;

    if (result.statusCode == 200) {
      githubuser = GithubUserModel.fromMap(result.data);
    }

    else if (result.statusCode == 401) {
      throw Exception('Não autorizado');
    }

    else if (result.statusCode == 403) {
      throw Exception('Forbidden');
    }

    else if (result.statusCode == 404) {
      throw Exception('Usuário não encontrado');
    }

    else {
      throw Exception('Erro desconhecido');
    }

    return githubuser;
  }
}   