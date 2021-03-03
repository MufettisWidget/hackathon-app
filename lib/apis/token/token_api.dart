import 'package:http/http.dart' as http;

import '../../main.dart';

class TokenApiServices {
  static final TokenApiServices _instance = TokenApiServices._init();
  TokenApiServices._init();
  static TokenApiServices instance = _instance;
//Kullanıcının uygulamaya giriş yaparken jwt token oluşturmasını sağlayan api servisi
  Future<http.Response> getToken(String deviceId, String cryptoDevice) async {
    var headers = <String, String>{'Content-Type': 'application/json'};

    final response = http.post(
      baseUrl + 'Token/GetMobileToken/$deviceId/$cryptoDevice',
      headers: headers,
    );
    return response;
  }
}
