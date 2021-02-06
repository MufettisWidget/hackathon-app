import 'package:http/http.dart' as http;

import '../../main.dart';

class TokenApiServices {
  static TokenApiServices _instance = TokenApiServices._init();
  TokenApiServices._init();
  static TokenApiServices instance = _instance;

  Future<http.Response> getToken(String deviceId, String cryptoDevice) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final response = http.post(
      baseUrl + 'Token/GetMobileToken/$deviceId/$cryptoDevice',
      headers: headers,
    );
    return response;
  }
}
