class SigninUserReq {
  final String email;
  String? password;

  SigninUserReq({
    required this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
