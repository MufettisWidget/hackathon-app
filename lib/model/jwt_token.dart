import 'dart:convert';

class JwtToken {
  String token;
  JwtToken();
  JwtToken.withId(this.token);

  JwtToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson(JwtToken token) {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["token"] = token.token;
    return data;
  }
}

String postToJsonNotice(JwtToken data) {
  final dyn = data.toJson(data);
  return json.encode(dyn);
}
