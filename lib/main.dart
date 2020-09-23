import 'package:flutter/material.dart';
import 'package:covid_stats/data.dart' as data;

void main() {
  runApp(CovidData());
}

class CovidDataState extends State<CovidData> {
  @override
  Widget build(BuildContext context) {
    final covidStats = data.fetchData();
    return Text(covidStats.toString());
  }
}

class CovidData extends StatefulWidget {
  @override
  CovidDataState createState() => CovidDataState();
}
