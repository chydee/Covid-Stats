import 'dart:convert' show json;
import 'package:http/http.dart' as http;

class DailyData {
  final String date;
  final int confirmed;
  final int deaths;
  final int recovered;

  DailyData({this.date, this.confirmed, this.deaths, this.recovered});
}

class CovidStatsData {
  final List<DailyData> nigeria;
  CovidStatsData({this.nigeria});
  factory CovidStatsData.fromJson(Map<String, dynamic> json) {
    List<DailyData> nigeria = json['Nigeria'].map<DailyData>((data) {
      return DailyData(
          date: data["date"],
          confirmed: data["confirmed"],
          deaths: data["deaths"],
          recovered: data["recovered"]);
    }).toList();
    return CovidStatsData(nigeria: nigeria);
  }
}

Future<CovidStatsData> fetchData() async {
  final response =
      await http.get('https://pomber.github.io/covid19/timeseries.json');
  if (response.statusCode == 200) {
    return CovidStatsData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load covid stats');
  }
}
