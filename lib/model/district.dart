class District {
  String id;
  String cityName;
  String districtName;
  String twitterAddress;
  int notifeCount;
  int closedCount;
  int solutionRate;

  District({this.cityName, this.twitterAddress, this.districtName});

  District.fromJson(Map<String, dynamic> json) {
    cityName = json['CityName'];
    districtName = json['DistrictName'];
    twitterAddress = json['TwitterAddress'];
    notifeCount = json['NotifeCount'];
    closedCount = json['ClosedCount'];
    solutionRate = json['SolutionRate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cityName'] = cityName;
    data['districtName'] = districtName;
    data['twitterAddress'] = twitterAddress;
    data['notifeCount'] = notifeCount;
    data['closedCount'] = closedCount;
    data['solutionRate'] = solutionRate;
    return data;
  }
}
