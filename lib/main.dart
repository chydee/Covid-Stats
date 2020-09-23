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

  Widget _buildRow(
      BuildContext context, data.DailyData dailyData, int prevDailyData) {
    int diff = dailyData.confirmed - prevDailyData;
    Color color = Colors.green;
    if (diff == 0) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.calendar_today,
          color: color,
          size: 24,
        ),
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
      ),
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
          actions: <Widget>[
            //action button
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    futureData = data.fetchData();
                  });
                })
          ],
        ),
        body: Center(
          child: FutureBuilder<data.CovidStatsData>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.nigeria.length,
                  itemBuilder: (context, index) {
                    int prevDailyData;
                    if (index > 1) {
                      prevDailyData =
                          snapshot.data.nigeria[index - 1].confirmed;
                    } else {
                      prevDailyData = 0;
                    }
                    data.DailyData dailyData = snapshot.data.nigeria[index];
                    return _buildRow(context, dailyData, prevDailyData);
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
