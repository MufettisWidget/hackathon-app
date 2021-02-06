class HomeRequestModel {
  String token;
  double latitude;
  double longitude;

  HomeRequestModel({this.token, this.latitude, this.longitude});

  HomeRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}
