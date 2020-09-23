import 'package:covid_stats/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailDailyStats extends StatelessWidget {
  final DailyData dailyData;

  final TextStyle cardTextStyle = TextStyle(
    fontSize: 20,
    height: 2,
  );
  DetailDailyStats({Key key, @required this.dailyData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid19 stats for " + dailyData.date),
      ),
      body: Container(
        child: ListView(
          children: [
            _buildCard(context, dailyData.confirmed.toString(), Colors.lime),
            Center(
              child: Text(
                "Confirmed",
                style: cardTextStyle,
              ),
            ),
            _buildCard(context, dailyData.deaths.toString(), Colors.red),
            Center(
              child: Text(
                "Deaths",
                style: cardTextStyle,
              ),
            ),
            _buildCard(context, dailyData.recovered.toString(), Colors.green),
            Center(
              child: Text(
                "Recovered",
                style: cardTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, String stat, Color color) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    height: 180,
    width: double.maxFinite,
    child: Card(
      elevation: 5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              stat,
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 72,
                height: 0.80,
                color: color,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
