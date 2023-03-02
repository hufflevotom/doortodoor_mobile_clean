class AuthExceptions implements Exception {
  const AuthExceptions(this.message);
  final String message;
}

class SignInException extends AuthExceptions {
  const SignInException(super.message);
}

class GetUserException extends AuthExceptions {
  const GetUserException(super.message);
}
