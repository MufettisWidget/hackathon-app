import 'package:MufettisWidgetApp/core/core_helper.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class CityApiService {
  static final CityApiService _instance = CityApiService._init();
  CityApiService._init();
  static CityApiService instance = _instance;

  Future<http.Response> getCity(String city) {
    final response = http.get(
      baseUrl + 'city/GetCity/$city',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  Future<http.Response> getCAllity() {
    final response = http.get(
      baseUrl + 'city',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  Future<http.Response> getMostCity() {
    final response = http.get(
      baseUrl + 'city/GetMostCity',
      headers: CoreHelper.getHeaderWithNotUserToken(),
    );
    return response;
  }

  Future<http.Response> getMostCitySolutionRate() {
    final response = http.get(
      baseUrl + 'city/GetMostCitySolutionRate',
      headers: CoreHelper.getHeaderWithNotUserToken(),
    );
    return response;
  }
}
