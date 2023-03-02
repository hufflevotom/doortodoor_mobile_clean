import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:doortodoor_app/app/preferences/preferences.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(
    this._authRepository,
    this._localPreferences,
  ) : super(SignInInitial()) {
    on<SignUp>(_onSignUp);
  }

  final AuthRepository _authRepository;
  final LocalPreferences _localPreferences;

  Future<void> _onSignUp(SignUp event, Emitter<SignInState> emit) async {
    emit(SignUpLoading());
    try {
      final response = await _authRepository.signIn(
        dni: event.documento,
        password: event.password,
      );
      if (response != '') {
        _localPreferences.setToken(response);
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure('Token Inválido'));
      }
    } on SignInException catch (e) {
      emit(SignUpFailure(e.message));
    }
  }
}
