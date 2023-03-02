part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

@immutable
class SignUp extends SignInEvent {
  SignUp({
    required this.documento,
    required this.password,
  });
  final String documento;
  final String password;
}
