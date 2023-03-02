import 'package:domain/src/auth/auth.dart';

abstract class AuthRepository {
  Future<String> signIn({required String dni, required String password});
  Future<User> getUser(String token);
}
