class LogoutReqParams {
  final String token;

  LogoutReqParams({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }
}
