class ModelToken {
  String accessToken;
  String refreshToken;

  ModelToken.fromMap(Map json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];

  Map toMap() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}
