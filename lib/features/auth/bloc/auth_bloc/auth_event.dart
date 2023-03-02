part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class RecoverSession extends AuthEvent {}

class SignOut extends AuthEvent {}

class AlertCleared extends AuthEvent {}
