import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/auth/repository/user_repository.dart';

class UserController {
  final UserRepository repository;
  final ProviderRef ref;

  UserController({
    required this.repository,
    required this.ref,
  });

  void signIn(String name, String email, String password) async {
    await repository.signin(name, email, password);
  }
}
