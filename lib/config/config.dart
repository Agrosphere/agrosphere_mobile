class Config {
  static const String apikey = 'd0a0a402661ff30e2d86434d18641e91';
  // static String baseApiUrl = 'https://f01f-45-123-222-158.ngrok-free.app/';
  static const String baseApiUrl = 'https://yajna.safalstha.com.np/';
  static const String kalimatiTarkari = 'https://kalimati.safalstha.com.np/';
  static const String userApiUrl = 'https://user.safalstha.com.np/';
  static const String chatApiUrl = 'https://chat.safalstha.com.np/';
  static const String webSocketChatApiUrl = 'wss://chat.safalstha.com.np/';
  static const String newsApiUrl = 'https://news.safalstha.com.np/';
  // static const String baseApiUrl = 'https://treksathi.safalstha.com.np/';

  // ignore: non_constant_identifier_names, constant_identifier_names
  static const String WEATHER_API_URL =
      "https://api.openweathermap.org/data/2.5";
  //current user accessToken
  static String? accessToken;
  static void setAccessToken(String? currentAccessToken) {
    if (currentAccessToken != Config.accessToken) {
      Config.accessToken = currentAccessToken;
    } else {
      //
    }
  }

  static String getApi(String endPoint) {
    return baseApiUrl + (endPoint);
  }
}
