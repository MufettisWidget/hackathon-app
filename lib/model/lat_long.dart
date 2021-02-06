class HomeLocationModel {
  double lat;
  double lng;
  String city;

  HomeLocationModel({this.lat, this.lng, this.city});

  HomeLocationModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
     city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city'] = this.city;
    return data;
  }
}
