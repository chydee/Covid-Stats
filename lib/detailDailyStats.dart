import 'package:covid_stats/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_stats/main.dart';

class DetailDailyStats extends StatelessWidget {
  final DailyData dailyData;
  DetailDailyStats({Key key, @required this.dailyData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid19 stats for " + dailyData.date),
      ),
      body: Center(
        child: Text(dailyData.confirmed.toString()),
      ),
    );
  }
}
