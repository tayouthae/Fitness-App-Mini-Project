import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/workout/Men/curlUp.dart';
import 'package:miniproject/workout/Men/diamond.dart';
import 'package:miniproject/workout/Men/jackknife.dart';
import 'package:miniproject/workout/Men/pullUp.dart';
import 'package:miniproject/workout/Men/pushUp.dart';
import 'package:miniproject/workout/Women/chinUp.dart';
import 'package:miniproject/workout/Women/dip.dart';
import 'package:miniproject/workout/Women/kickback.dart';
import 'package:miniproject/workout/Women/lunge.dart';
import 'package:miniproject/workout/Women/squats.dart';

class Plans extends StatefulWidget {
  @override
  _PlanDiet createState() => _PlanDiet();
}

class _PlanDiet extends State<Plans> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Workout Routine'),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                ),
                Image(
                  image: AssetImage('assets/workout.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Monday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Tuesday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Wednsday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Thursday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Friday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Saturday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      child: new Text("Sunday"),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DayOne()),
                        );
                      },
                      height: 100,
                      minWidth: 100,
                      color: Colors.blueAccent,
                    ),
                  ],
                )
              ],
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class DayOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monday"),
      ),
      body: ListView(
        children: <Widget>[
          Center(
              child: Text(
            'Men',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          DataTable(
            columns: [
              DataColumn(
                  label: Text('Exercise',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Sets',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Reps',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(
                  cells: [
                    DataCell(Text('Push Up')),
                    DataCell(Text('2-5')),
                    DataCell(Text('10-20')),
                  ],
                  onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PushUp(),
                        ),
                      );
                    }
                  }),
              DataRow(cells: [
                DataCell(Text('Medium-Grip Pull Up')),
                DataCell(Text('2-5')),
                DataCell(Text('10-20')),
              ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PullUP(),
                        ),
                      );
                    }
                  }),
              DataRow(cells: [
                DataCell(Text('Handstand or Jackknife Push Up')),
                DataCell(Text('2-5')),
                DataCell(Text('10-20')),
              ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => JackKnife(),
                        ),
                      );
                    }
                  }),
              DataRow(cells: [
                DataCell(Text('Diamond Push Up')),
                DataCell(Text('2-5')),
                DataCell(Text('10-20')),
              ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Diamond(),
                        ),
                      );
                    }
                  }),
              DataRow(cells: [
                DataCell(Text('Inverted Rack Curl Up')),
                DataCell(Text('2-5')),
                DataCell(Text('10-20')),
              ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CurlUp(),
                        ),
                      );
                    }
                  }),
            ],
          ),
          Center(
              child: Text(
            'Women',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text('Exercise',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Sets',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Reps',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Bodyweight Squats')),
                  DataCell(Text('3-6')),
                  DataCell(Text('10-15')),
                ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Squats(),
                        ),
                      );
                    }
                  }),
                DataRow(cells: [
                  DataCell(Text('Pushups')),
                  DataCell(Text('3-6')),
                  DataCell(Text('10-15')),
                ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PushUp(),
                        ),
                      );
                    }
                  }),
                DataRow(cells: [
                  DataCell(Text('Bodyweight Lunge')),
                  DataCell(Text('3-6')),
                  DataCell(Text('10-15')),
                ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Lunge(),
                        ),
                      );
                    }
                  }),
                DataRow(cells: [
                  DataCell(Text('Chin Up or Resistance Band Pulldown')),
                  DataCell(Text('3-6')),
                  DataCell(Text('10-15')),
                ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ChinUp(),
                        ),
                      );
                    }
                  }),
                DataRow(cells: [
                  DataCell(Text('Glute Kick Back')),
                  DataCell(Text('3-6')),
                  DataCell(Text('10-15')),
                ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Kick(),
                        ),
                      );
                    }
                  }),
                DataRow(cells: [
                  DataCell(Text('Tricep Bench Dip')),
                  DataCell(Text('3-6')),
                  DataCell(Text('10-15')),
                ],onSelectChanged: (bool selected) {
                    if (selected) {
                      
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Dip(),
                        ),
                      );
                    }
                  }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
