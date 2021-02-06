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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['districtName'] = this.districtName;
    data['twitterAddress'] = this.twitterAddress;
    data['notifeCount'] = this.notifeCount;
    data['closedCount'] = this.closedCount;
    data['solutionRate'] = this.solutionRate;
    return data;
  }
}
