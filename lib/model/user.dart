import 'dart:convert';

import 'notice.dart';

String postToJsonUser(User data) {
  final dyn = data.toJson(data);
  return json.encode(dyn);
}

class User {
  String id;
  String mailAddress;
  String nameSurname;
  String password;
  String phone;

  bool isKvkk;
  String userToken;

  List<Notice> noticies;

  User(this.nameSurname, this.mailAddress, this.phone, this.password);

  User.fromJson(Map<String, dynamic> json) {
    nameSurname = json['nameSurname'];
    mailAddress = json['mailAddress'];
    phone = json['phone'];
    password = json['password'];
    isKvkk = json['isKvkk'];
    userToken = json['UserToken'];
    id = json['Id'];
    if (json['noticies'] != null) {
      noticies = <Notice>[];
      json['noticies'].forEach((v) {
        noticies.add(Notice.fromJson(v));
      });
    }
  }

  User.withId(this.id, this.mailAddress);

  Map<String, dynamic> toJson(User user) {
    final data = <String, dynamic>{};
    data['mailAddress'] = user.mailAddress;
    data['nameSurname'] = user.nameSurname;
    data['phone'] = user.phone;
    data['password'] = user.password;
    data['isKvkk'] = user.isKvkk;
    data['Id'] = user.id;
    data['UserToken'] = user.userToken;
    if (user.noticies != null) {
      data['noticies'] = user.noticies.map((e) => e.toJson(e)).toList();
    }
    return data;
  }
}
