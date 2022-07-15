import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:miniproject/Diet%20Notification/notify.dart';
import 'package:miniproject/home/screens/caloriegraph.dart';

class ViewGraph extends StatelessWidget {
  final List<CalorieGraph> data;

  ViewGraph({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CalorieGraph, String>> series = [
      charts.Series(
          id: "Calorie",
          data: data,
          domainFn: (CalorieGraph series, _) => series.totalCalorie,
          domainUpperBoundFn: (CalorieGraph series, _) => series.totalCalorie,
          domainLowerBoundFn: (CalorieGraph series, _) => series.totalCalorie,
          measureFn: (CalorieGraph series, _) => series.calorieInTake,
          colorFn: (CalorieGraph series, _) => series.barColor)
    ];
    return Scaffold(
    body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/graph.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      child: Center(
      child: Column (
        children: <Widget>[
         Container(
      height: 400,
      margin: EdgeInsets.only(top: 120),
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Calorie Count according to day",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              
              Expanded(
                  child: charts.BarChart(
                series,
                animate: true,
              )),Text("Total Calorie Consumed"),
            ],
          ),
        ),
      ),
      ),
       Container(
                        height: 50,
                        width: 150,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue)),
                          color: Colors.white,
                          textColor: Colors.blue,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Notify()),
                            );
                          },
                          child: Text(
                            "Set Diet Timing".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
    ]
    )
      ),
      ),
    );
  }
}
