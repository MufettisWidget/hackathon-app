import 'package:http/http.dart' as http;

import '../../core/shared_prefernces_api.dart';
import '../../main.dart';

class DistrictApiServices {
  static DistrictApiServices _instance = DistrictApiServices._init();
  DistrictApiServices._init();
  static DistrictApiServices instance = _instance;

//İlçe bilgisi için çalışan api servisi
  Future<http.Response> getDistrict(String city, String district) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'district/GetDistrict/$city/$district',
      headers: headers,
    );
    return response;
  }

// Bütün ilçe bilgisi için çalışan api servisi
  Future<http.Response> getAllDistrict() async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'district',
      headers: headers,
    );
    return response;
  }

//En çok bildirim alan ilçe bilgileri için çalışan api servisi
  Future<http.Response> getMostDistrict() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};

    final response = http.get(
      baseUrl + 'district/GetMostCity',
      headers: headers,
    );
    return response;
  }

//En çok çözüm üreten ilçe bilgileri için çalışan api servisi
  Future<http.Response> getMostDistrictSolutionRate() {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    final response = http.get(
      baseUrl + 'district/GetMostCitySolutionRate',
      headers: headers,
    );
    return response;
  }
}
