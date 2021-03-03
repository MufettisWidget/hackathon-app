class City {
  String id;
  String cityName;
  String twitterAddress;
  int notifeCount;
  int closedCount;
  int solutionRate;

  City({cityName, twitterAddress});

  City.fromJson(Map<String, dynamic> json) {
    cityName = json['CityName'];
    twitterAddress = json['TwitterAddress'];
    notifeCount = json['NotifeCount'];
    closedCount = json['ClosedCount'];
    solutionRate = json['SolutionRate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cityName'] = cityName;
    data['twitterAddress'] = twitterAddress;
    data['notifeCount'] = notifeCount;
    data['closedCount'] = closedCount;
    data['solutionRate'] = solutionRate;

    return data;
  }
}
