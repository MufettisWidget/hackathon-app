import 'package:MufettisWidgetApp/core/core_helper.dart';
import 'package:http/http.dart' as http;

import '../../core/shared_prefernces_api.dart';
import '../../main.dart';
import '../../model/user.dart';

//Kullanıcın sisteme üye olması için çalışan api servisi
class AccountApiServices {
  static Future<http.Response> createUser(User user) async {
    var headers = <String, String>{'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    final response = await http.post(baseUrl + 'user/CreateUser', headers: headers, body: postToJsonUser(user));
    return response;
  }

//Kullanıcın sisteme giriş yapabilmesi için çalışan api servisi
  static Future<http.Response> loginUser(String email, String password) async {
    final response = await http.get(
      baseUrl + 'user/GetUserLogin/$email/$password',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  static Future<http.Response> changePassword(String userId, String oldPassword, String newPassword) async {
    final response = await http.get(
      baseUrl + 'user/changePassword/$userId/$oldPassword/$newPassword',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  static Future<http.Response> changeMailAddress(String userId, String password, String newEmail) async {
    final response = await http.get(
      baseUrl + 'user/ChangeEmail/$userId/$password/$newEmail',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  static Future<http.Response> updateUser(User userIn) async {
    final response = await http.put(baseUrl + 'user', headers: CoreHelper.getHeaderWithJwtToken(), body: postToJsonUser(userIn));
    return response;
  }

  static Future<http.Response> successUser(String id) async {
    final response = await http.put(baseUrl + 'User/UpdateUserSuccess/' + id, headers: CoreHelper.getHeaderWithJwtToken());
    return response;
  }

  static Future<http.Response> renewPassword(String userId, String newPassword) async {
    final response = await http.get(
      baseUrl + 'user/renewPassword/$userId/$newPassword',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }

  static Future<http.Response> forgotPassword(String email) async {
    final response = await http.get(
      baseUrl + 'user/forgotPassword/$email',
      headers: CoreHelper.getHeaderWithJwtToken(),
    );
    return response;
  }
}
