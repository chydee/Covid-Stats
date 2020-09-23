import 'package:covid_stats/detailDailyStats.dart';
import 'package:flutter/material.dart';
import 'package:covid_stats/data.dart' as data;

void main() {
  runApp(CovidData());
}

class CovidDataState extends State<CovidData> {
  Future<data.CovidStatsData> futureData;

  void initState() {
    super.initState();
    futureData = data.fetchData();
  }

  final _font = const TextStyle(fontSize: 18.0);
  final _biggerFont = const TextStyle(fontSize: 20.0);

  Widget _buildRow(BuildContext context, data.DailyData dailyData) {
    return ListTile(
      title: Text(
        dailyData.date,
        style: _font,
      ),
      trailing: Text(
        dailyData.confirmed.toString(),
        style: _biggerFont,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailDailyStats(
                    dailyData: dailyData,
                  )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Stats App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid Stats App'),
        ),
        body: Center(
          child: FutureBuilder<data.CovidStatsData>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.nigeria.length,
                  itemBuilder: (context, index) {
                    data.DailyData dailyData = snapshot.data.nigeria[index];
                    return _buildRow(context, dailyData);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //By Default, show  a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class CovidData extends StatefulWidget {
  @override
  CovidDataState createState() => CovidDataState();
}
