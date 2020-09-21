class DailyData {
  final String date;
  final int confirmed;
  final int deaths;
  final int recovered;

  DailyData({this.date, this.confirmed, this.deaths, this.recovered});
}

class CovidData {
  final List<DailyData> nigeria;
  CovidData({this.nigeria});
  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
      nigeria: json['Nigeria'],
    );
  }
}
