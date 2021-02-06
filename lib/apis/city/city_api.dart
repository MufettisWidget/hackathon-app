import 'package:http/http.dart' as http;

import '../../core/shared_prefernces_api.dart';
import '../../main.dart';

class CityApiService {
  static CityApiService _instance = CityApiService._init();
  CityApiService._init();
  static CityApiService instance = _instance;

  Future<http.Response> getCity(String city) {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = http.get(
      baseUrl + 'city/GetCity/$city',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getCAllity() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = http.get(
      baseUrl + 'city',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> ggetMostCity() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};

    final response = http.get(
      baseUrl + 'city/GetMostCity',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getMostCitySolutionRate() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    final response = http.get(
      baseUrl + 'city/GetMostCitySolutionRate',
      headers: headers,
    );
    return response;
  }
}
