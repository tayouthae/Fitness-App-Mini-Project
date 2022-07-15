import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:miniproject/home/screens/Pedometer_1.dart';
import 'package:miniproject/home/screens/caloriegraph.dart';
import 'package:miniproject/home/screens/second.dart';
import 'package:miniproject/home/screens/third.dart';
import 'package:miniproject/home/screens/graph.dart';
import 'package:miniproject/home/screens/fourth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BottomNavBar extends StatefulWidget {
  static const String id = 'BottomNavBar';
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final Exercise _sites = new Exercise();
  final Stepcount _dashboard = new Stepcount();
  final Second _clients = new Second();
  final Fourth _flutterpages = new Fourth();
  final dbRef = FirebaseDatabase.instance.reference().child("details");
  final calRef = FirebaseDatabase.instance.reference().child("DailyCalorie");
  final List<CalorieGraph> data = [];
  final list = [];
  // final cal = [1200, 2000, 2500, 2300, 2400];
  final cal = [];

  @override
  void initState() {
    chartShow();
    super.initState();
  }

  Future chartShow() async {
    await dbRef.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> checkData = snap.value;
      if (list.length == 0) {
      } else {
        list.clear();
      }
      // print(checkData);
      checkData.forEach((id, value) {
        try {
          var test = value as Map<dynamic, dynamic>;
          test.forEach((idtest, valuetest) {
            // print("the value Test is" + valuetest);
            list.add(valuetest);
          });
        } catch (e) {}
        // print(value);
      });
    });
    // int index = 0;
    // list.forEach((element) {
    //   // print('element');
    //   // print(element);

    //   data.add(CalorieGraph(
    //     calorieInTake: double.parse(element),
    //     totalCalorie: list2[index].toString(),
    //     barColor: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
    //   ));
    //   index = index + 1;
    // });

    await calRef.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> calData = snap.value;
      if (cal.length == 0) {
      } else {
        cal.clear();
      }

      calData.forEach((id, value) {
        try {
          var test = value as Map<dynamic, dynamic>;
          // print(test);
          test.forEach((idtest, valuetest) {
            // print("the value Test is");
            // print(valuetest);
            cal.add(valuetest);
          });
        } catch (e) {}
        // print(value);
      });
    });
    print("cal");
    print(cal);

    int index = 0;
    if (cal.length != 0) {
      list.forEach((element) {
        // print('element');
        // print(element);

        data.add(CalorieGraph(
          calorieInTake: double.parse(element),
          totalCalorie: cal[index].toString(),
          barColor: charts.ColorUtil.fromDartColor(Color(0xFF400B0FF)),
        ));
        index = index + 1;
      });
    }
  }

  Widget _showPage = new Stepcount();

  Widget _pageChooser(int page) {
    print('hello');
    // dbRef.once().then((DataSnapshot snap) {
    //   Map<dynamic, dynamic> checkData = snap.value;
    //   if (list.length == 0) {
    //   } else {
    //     list.clear();
    //   }
    //   // print(checkData);
    //   checkData.forEach((id, value) {
    //     try {
    //       var test = value as Map<dynamic, dynamic>;
    //       test.forEach((idtest, valuetest) {
    //         // print("the value Test is" + valuetest);
    //         list.add(valuetest);
    //       });
    //     } catch (e) {}
    //     // print(value);
    //   });
    // });
    // // int index = 0;
    // // list.forEach((element) {
    // //   // print('element');
    // //   // print(element);

    // //   data.add(CalorieGraph(
    // //     calorieInTake: double.parse(element),
    // //     totalCalorie: list2[index].toString(),
    // //     barColor: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
    // //   ));
    // //   index = index + 1;
    // // });

    // calRef.once().then((DataSnapshot snap) {
    //   Map<dynamic, dynamic> calData = snap.value;
    //   if (cal.length == 0) {
    //   } else {
    //     cal.clear();
    //   }

    //   calData.forEach((id, value) {
    //     try {
    //       var test = value as Map<dynamic, dynamic>;
    //       // print(test);
    //       test.forEach((idtest, valuetest) {
    //         // print("the value Test is");
    //         // print(valuetest);
    //         cal.add(valuetest);
    //       });
    //     } catch (e) {}
    //     // print(value);
    //   });
    // });
    // print("cal");
    // print(cal);

    // int index = 0;
    // if (cal.length != 0) {
    //   list.forEach((element) {
    //     // print('element');
    //     // print(element);

    //     data.add(CalorieGraph(
    //       calorieInTake: double.parse(element),
    //       totalCalorie: cal[index].toString(),
    //       barColor: charts.ColorUtil.fromDartColor(Color(0xFF400B0FF)),
    //     ));
    //     index = index + 1;
    //   });
    // }
    // print('Dashboard');
    // print(list);
    // print('Hello');
    // print(data);
    switch (page) {
      case 0:
        return _dashboard;
        break;
      case 1:
        return _clients;
        break;
      case 2:
        return _sites;
        break;
      case 3:
        return _flutterpages;
        break;
      case 4:
        return ViewGraph(data: data);
        break;
      default:
        return new Center(
          child: new Center(
            child: new Text(
              '404 Page Not Found',
              style: new TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: pageIndex,
        height: 50.0,
        items: <Widget>[
          Icon(FontAwesomeIcons.shoePrints, size: 23),
          Icon(FontAwesomeIcons.utensils, size: 30),
          Icon(FontAwesomeIcons.dumbbell, size: 30),
          Icon(FontAwesomeIcons.fileMedicalAlt, size: 30),
          Icon(FontAwesomeIcons.map, size: 30),
        ],
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),

      // body: FutureBuilder(
      //     future: dbRef.once(),
      //     builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
      //       if (snapshot.hasData) {
      //         list.clear();
      //         Map<dynamic, dynamic> values = snapshot.data.value;
      //         values.forEach((key, values) {
      //           list.add(values);
      //         });
      //         // print('the value is ' + list[7].toString());

      //         list.forEach((e) => {
      //               print(
      //                 'loop value is : ' +
      //                     jsonDecode(e.toString())["calorie"].toString(),
      //               )
      //               // CalorieGraph(
      //               //   calorieInTake: e.calorie,
      //               //   totalCalorie: 2500.toString(),
      //               //   barColor:
      //               //       charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
      //               // ),
      //             });
      //         return new ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: list.length,
      //             itemBuilder: (BuildContext context, int index) {
      //               return Card(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: <Widget>[
      //                     Text("Name: "),
      //                   ],
      //                 ),
      //               );
      //             });
      //       }
      //       return CircularProgressIndicator();
      //     }));
    );
  }
}
