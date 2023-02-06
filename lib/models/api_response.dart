class LoginResponse {
  final bool status;
  String? message;
  String? token;

  LoginResponse({
    required this.status,
    this.message,
    this.token,
  });
}

class RegisterResponse {
  final bool status;

  const RegisterResponse({
    required this.status,
  });
}
