class AuthUser {
  String phone;
  String password;
  String? accessToken;

  AuthUser({
    required this.phone,
    required this.password,
    this.accessToken,
  });

  AuthUser copyWith({
    String? phone,
    String? password,
    String? accessToken,
  }) {
    return AuthUser(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
