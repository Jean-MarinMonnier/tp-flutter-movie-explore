class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token']);
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "refresh_token": refreshToken
    };
}
}