import 'package:http/http.dart' as http;

import '../../core/shared_prefernces_api.dart';
import '../../main.dart';

class DistrictApiServices {
  static DistrictApiServices _instance = DistrictApiServices._init();
  DistrictApiServices._init();
  static DistrictApiServices instance = _instance;

  Future<http.Response> getDistrict(String city, String district) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'district/GetDistrict/$city/$district',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getAllDistrict() async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'district',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> ggetMostDistrict() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};

    final response = http.get(
      baseUrl + 'district/GetMostCity',
      headers: headers,
    );
    return response;
  }

  Future<http.Response> getMostDistrictSolutionRate() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    final response = http.get(
      baseUrl + 'district/GetMostCitySolutionRate',
      headers: headers,
    );
    return response;
  }
}
