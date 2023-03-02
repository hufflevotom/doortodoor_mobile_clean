import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:doortodoor_app/app/preferences/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository, this._preferences, this._foliosRepository)
      : super(AuthInitial()) {
    on<RecoverSession>(_onRecoverSession);
    on<SignOut>(_onSignOut);
    on<AlertCleared>(_onAlertCleared);
  }

  final LocalPreferences _preferences;
  final AuthRepository _authRepository;
  final FoliosRepository _foliosRepository;

  Future<void> _onRecoverSession(
    RecoverSession event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    if (_preferences.token == null) {
      emit(Unauthenticated());
    } else {
      try {
        final user = await _authRepository.getUser(_preferences.token!);
        if (user.ruta != null) {
          try {
            final folios = await _foliosRepository.getFolios(user.ruta!);
            emit(Authenticated(user: user, folios: folios, alert: ''));
          } catch (e) {
            emit(
              Authenticated(
                user: user,
                folios: const [],
                alert: 'Error al obtener folios',
              ),
            );
          }
        } else {
          emit(Authenticated(user: user, folios: const [], alert: ''));
        }
      } catch (e) {
        emit(Unauthenticated());
      }
    }
  }

  void _onAlertCleared(
    AlertCleared event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(alert: ''));
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    _preferences.removetoken();
    emit(Unauthenticated());
  }
}
