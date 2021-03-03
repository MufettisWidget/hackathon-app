import 'package:MufettisWidgetApp/core/core_helper.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class DistrictApiServices {
  static final DistrictApiServices _instance = DistrictApiServices._init();
  DistrictApiServices._init();
  static DistrictApiServices instance = _instance;

  Future<http.Response> getDistrict(String city, String district) async {
    final response = await http.get(
      baseUrl + 'district/GetDistrict/$city/$district',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  Future<http.Response> getAllDistrict() async {
    final response = await http.get(
      baseUrl + 'district',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  Future<http.Response> getMostDistrict() {
    final response = http.get(
      baseUrl + 'district/GetMostCity',
      headers: CoreHelper.getHeaderWithNotUserToken(),
    );
    return response;
  }

  Future<http.Response> getMostDistrictSolutionRate() {
    final response = http.get(
      baseUrl + 'district/GetMostCitySolutionRate',
      headers: CoreHelper.getHeaderWithNotUserToken(),
    );
    return response;
  }
}
