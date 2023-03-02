part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.folios,
    this.alert,
  });
  final User? user;
  final List<Folios>? folios;
  final String? alert;

  @override
  List<Object?> get props => [user, folios, alert];

  AuthState copyWith({
    User? user,
    List<Folios>? folios,
    String? alert,
  }) {
    return Authenticated(
      user: user ?? this.user!,
      folios: folios ?? this.folios,
      alert: alert ?? this.alert,
    );
  }
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated({required User super.user, super.folios, super.alert});
}

class Unauthenticated extends AuthState {}
