class City {
  String id;
  String cityName;
  String twitterAddress;
  int notifeCount;
  int closedCount;
  int solutionRate;

  City({this.cityName, this.twitterAddress});

  City.fromJson(Map<String, dynamic> json) {
    cityName = json['CityName'];
    twitterAddress = json['TwitterAddress'];
    notifeCount = json['NotifeCount'];
    closedCount = json['ClosedCount'];
    solutionRate = json['SolutionRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityName'] = this.cityName;
    data['twitterAddress'] = this.twitterAddress;
    data['notifeCount'] = this.notifeCount;
    data['closedCount'] = this.closedCount;
    data['solutionRate'] = this.solutionRate;

    return data;
  }
}
