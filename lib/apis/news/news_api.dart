import 'package:MufettisWidgetApp/core/core_helper.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class NewsApiServices {
  static Future<http.Response> getAllNews() async {
    final response = http.get(
      baseUrl + 'news',
      headers: CoreHelper.getHeaderWithNotUserToken(),
    );
    return response;
  }
}
