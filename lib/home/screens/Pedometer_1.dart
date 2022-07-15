import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:miniproject/auth.dart';
import 'package:miniproject/bmi/screens/inputCalorie.dart';
import 'package:miniproject/bmi/screens/input_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
// import 'package:hiking_calories_calculator/hiking_calories_calculator.dart';
import 'package:hiking_calories_calculator/calculator/calculation.dart';
import 'package:hiking_calories_calculator/calculator/calories_calculator.dart';
import 'package:hiking_calories_calculator/calculator/speed.dart';
import 'package:hiking_calories_calculator/calculator/terrain_factors.dart';
import 'package:hiking_calories_calculator/calculator/weight.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Stepcount extends StatefulWidget {
  @override
  _StepcountState createState() => _StepcountState();
}

class _StepcountState extends State<Stepcount> {
  String muestrePasos = "";
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;

  double _numerox; //numero pasos
  double _convert;
  double _kmx;
  double burnedx;
  double _porciento;
  // double percent=0.1;
  FlutterLocalNotificationsPlugin notify;

  final dbRef = FirebaseDatabase.instance.reference().child("Time");
  final dietRef = FirebaseDatabase.instance.reference().child("Muscle Gain");
  final timing = [];
  final dietList = [];

  @override
  void initState() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kathmandu"));
    super.initState();
    //initPlatformState();
    setUpPedometer();
    var androidInitialize = new AndroidInitializationSettings('heroku');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizeSetting = new InitializationSettings(
        android: androidInitialize, iOS: iOSinitilize);
    notify = new FlutterLocalNotificationsPlugin();
    notify.initialize(initilizeSetting,
        onSelectNotification: notificationSelected);
  }

  // Future<void> _zonedScheduleNotification() async {
  //   await notify.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'scheduled body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('2021',
  //               'Mini Project', 'Final Demo of Mini Project')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  //           print(DateTime.now());
  // }
  Future _showNotification2() async {
    var time = Time(10, 58, 0);
    var androidDetails = new AndroidNotificationDetails(
        "0", "title", 'description',
        importance: Importance.max);

    var iOSdetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSdetails);

    // await notify.show(0, "Title", "body", generalNotificationDetails,
    //     payload: "Task");

    // var scheduledTime = DateTime.now().add(Duration(seconds: 5));
    // print(DateTime.now());
    // notify.schedule(
    //     1, "title", "body", scheduledTime, generalNotificationDetails);

    await notify.showDailyAtTime(
        0, "title", "dietName", time, generalNotificationDetails);
  }

  Future _showNotification(int singletiming, String dietName, int temp) async {
    var time = Time(10, 35, 0);
    var title = temp == 0
        ? "Breakfast"
        : temp == 1 ? "Dinner" : temp == 2 ? "Snacks" : "Lunch";
    var androidDetails = new AndroidNotificationDetails(
        temp.toString(), title, 'description',
        importance: Importance.max);

    var iOSdetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSdetails);

    // await notify.show(0, "Title", "body", generalNotificationDetails,
    //     payload: "Task");

    // var scheduledTime = DateTime.now().add(Duration(seconds: 5));
    // print(DateTime.now());
    // notify.schedule(
    //     1, "title", "body", scheduledTime, generalNotificationDetails);

    await notify.showDailyAtTime(
        temp, title, dietName, time, generalNotificationDetails,
        payload: dietName);
  }

  void _getTime() {
    dbRef.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> checkData = snap.value;
      if (timing.length == 0) {
      } else {
        timing.clear();
      }
      print("CheckDATA");
      print(checkData);
      checkData.forEach((id, value) {
        if (value != null)
          timing.add(value);
        else
          timing.add(0);
      });
    });
    print("List is ");
    print(timing);
  }

  void _getDiet() {
    dietRef.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> checkData = snap.value;
      if (dietList.length == 0) {
      } else {
        dietList.clear();
      }
      print("CheckDATA");
      print(checkData['Type']);

      if (checkData['Type'] == "Non-Veg") {
        print(checkData['Non-Veg'].runtimeType);
        checkData['Non-Veg'].forEach((id, value) {
          dietList.add(value);
        });
      } else {
        checkData['Veg'].forEach((id, value) {
          dietList.add(value);
        });
      }
    });
    print("diet list is ");
    print(dietList);
  }

  //inicia codigo pedometer
  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    print(stepCountValue); //impresion numero pasos por consola
    setState(() {
      _stepCountValue = "$stepCountValue";
      print(_stepCountValue);
    });

    var dist = stepCountValue; //pasamos el entero a una variable llamada dist
    double y = (dist + .0); //lo convertimos a double una forma de varias

    setState(() {
      _numerox =
          y; //lo pasamos a un estado para ser capturado ya convertido a double
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void calculateCalorie() {
    Calculation calculation = CaloriesCalculator.calculateCalories(
        weight: Weight(lbs: 120),
        bagWeight: Weight(lbs: 20),
        speed: Speed(mph: 4),
        terrain: Terrains.WET_CLAY_OR_ICE,
        inclination: 0);
    print("\nCalories per Hour:");
    print(calculation.kcalPerHour.ceil().toString());
    print("\nCalories per Mile:");
    print(calculation.kcalPerMile.ceil().toString());
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

  //fin codigo pedometer

  @override
  Widget build(BuildContext context) {
    // print(_stepCountValue);
    // print(int.parse(_stepCountValue).runtimeType);
    // _getTime();
    // _getDiet();
    // print(timing[2]);
    // print(dietList[2]);
    // for (var i = 0; i < 4; i++) {
    //   _showNotification(timing[i], dietList[i], i);
    // }
    _showNotification2();
    // _zonedScheduleNotification();
    calculateCalorie();
    getBurnedRun();

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
            title: const Text('Step Counter'),
            backgroundColor: Colors.blueAccent,
            actions: [
              Container(
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).googlelogout();

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
        body: new ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 230.0,
                  lineWidth: 20.0,
                  percent: _stepCountValue == 'Unknown'
                      ? 0
                      : double.parse(_stepCountValue) / 10000000000,
                  // percent: 0.5,
                  animation: true,
                  center: Container(
                    child: Center(
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(
                              FontAwesomeIcons.walking,
                              size: 30.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Container(
                            //color: Colors.orange,
                            child: Text(
                              _stepCountValue == 'Unknown'
                                  ? '0'
                                  : '$_stepCountValue',
                              // 'Walk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.blueAccent),
                            ),
                            // height: 50.0,
                            // width: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // percent: _convert,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blueAccent,
                ),
                // RaisedButton(
                //   onPressed: () {
                //     Provider.of<Auth>(context, listen: false).googlelogout();

                //     Navigator.pop(context);
                //   },
                //   child: Text("Logout"),
                // )
              ],
            ),
            Center(
              child: Text(
                'Daily Goal =10000',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '         DISTANCE',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '         $_km',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'km',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'CALORIES',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$_kmx',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' cal',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    InkWell(
                        child: Container(
                          height: 140.0,
                          width: 180.0,
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            image: DecorationImage(
                              image: new AssetImage('assets/Bmi/bmi.jpg'),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputPage()),
                          );
                        }),
                    Text(
                      "BMI Calculator",
                      style: TextStyle(
                        color: Colors.black,
                        //    fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        height: 140.0,
                        width: 180.0,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          image: DecorationImage(
                            image: new AssetImage('assets/Bmi/calorie.png'),
                            fit: BoxFit.contain,
                          ),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                      ),
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalorieIntake()),
                          );
                        }
                        ),
                    Text(
                      "Calorie Intake",
                      style: TextStyle(
                        color: Colors.black,
                        //         fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("You should eat: $payload"),
      ),
    );
  }
}
