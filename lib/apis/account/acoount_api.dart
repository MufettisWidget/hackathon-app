import 'package:http/http.dart' as http;

import '../../core/shared_prefernces_api.dart';
import '../../main.dart';
import '../../model/user.dart';

//Kullanıcın sisteme üye olması için çalışan api servisi
class AccountApiServices {
  static Future<http.Response> createUser(User user) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};

    final response = await http.post(baseUrl + 'user/CreateUser', headers: headers, body: postToJsonUser(user));
    return response;
  }

//Kullanıcın sisteme giriş yapabilmesi için çalışan api servisi
  static Future<http.Response> loginUser(String email, String password) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    final response = await http.get(
      baseUrl + 'user/GetUserLogin/$email/$password',
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> changePassword(String userId, String oldPassword, String newPassword) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'user/changePassword/$userId/$oldPassword/$newPassword',
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> changeMailAddress(String userId, String password, String newEmail) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'user/ChangeEmail/$userId/$password/$newEmail',
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> updateUser(User userIn) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.put(baseUrl + 'user', headers: headers, body: postToJsonUser(userIn));
    return response;
  }

  static Future<http.Response> successUser(String id) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.put(baseUrl + 'User/UpdateUserSuccess/' + id, headers: headers);
    return response;
  }

  static Future<http.Response> renewPassword(String userId, String newPassword) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().jwtToken};
    final response = await http.get(
      baseUrl + 'user/renewPassword/$userId/$newPassword',
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> forgotPassword(String email) async {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer  ' + SharedManager().tokenNotUser};
    final response = await http.get(
      baseUrl + 'user/forgotPassword/$email',
      headers: headers,
    );
    return response;
  }
}
