part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignUpSuccess extends SignInState {}

class SignUpLoading extends SignInState {}

class SignUpFailure extends SignInState {
  SignUpFailure(this.error);
  final String error;
}
