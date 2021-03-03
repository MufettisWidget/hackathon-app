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
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['city'] = city;
    return data;
  }
}
