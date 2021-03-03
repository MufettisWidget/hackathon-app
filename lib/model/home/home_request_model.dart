class HomeRequestModel {
  String token;
  double latitude;
  double longitude;

  HomeRequestModel({token, latitude, longitude});

  HomeRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Token'] = token;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    return data;
  }
}
