import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State {
  FlutterLocalNotificationsPlugin fltrNotification;
  double _height;
  double _width;
  String _selectedParam;
  String _preference;
  String task;
  int val;
  String _setTime;
  String _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();

  String breakfast;
  String lunch;
  String snacks;
  String dinner;
  String meal;

  final dbRef = FirebaseDatabase.instance.reference().child("Time");
  final dietRef = FirebaseDatabase.instance.reference().child("Muscle Gain");

  Future<Null> _selectTime(BuildContext context) async {
    // print("object");
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        print("hour");
        print(_hour);
        _minute = selectedTime.minute.toString();
        print("minute");
        print(_minute);
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    // print(_timeController.text);
  }

  @override
  void initState() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kathmandu"));
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('heroku');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    String task;
    String title = _selectedParam;
    print(_preference.runtimeType);
    print("_preference");
    await dietRef.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> checkData = snap.value;

      if (checkData['Type'] == "Non-Veg") {
        meal = "Non-Veg";
      } else {
        meal = "Veg";
      }

      print("checkData");
      print(checkData["Non-Veg"]);
      print(_preference);
      checkData[_preference].forEach((id, value) {
        if (id == "Breakfast") {
          breakfast = value;
          print(value);
        } else if (id == "Lunch") {
          lunch = value;
        } else if (id == "Snacks") {
          snacks = value;
        } else {
          dinner = value;
          print(value);
        }
      });
    });

    var androidDetails = new AndroidNotificationDetails("Channel ID",
        "Mini Project", "Set time for the meal for trigerring the notification",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails, payload: "Task");
    var scheduledTime;
    scheduledTime = DateTime.now().add(Duration(seconds: 5));

    // scheduledTime = Time(int.parse(_hour), int.parse(_minute), 0);

    if (_selectedParam == "Breakfast") {
      dbRef.child("Breakfast").set(_timeController.text);
      task = breakfast;
    } else if (_selectedParam == "Lunch") {
      dbRef.child("Lunch").set(_timeController.text);
      task = lunch;
    } else if (_selectedParam == "Snacks") {
      dbRef.child("Snacks").set(_timeController.text);
      task = snacks;
    } else {
      dbRef.child("Dinner").set(_timeController.text);
      task = dinner;
    }
    print("task");
    print(task);
    fltrNotification.schedule(
        // await fltrNotification.showDailyAtTime(
        1,
        title,
        task,
        scheduledTime,
        generalNotificationDetails,
        payload: task);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/notify.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, right: 15.0, left: 15.0, bottom: 0),
                    child: Text(
                      "*We recommend to set all meals time for daily notification (If not selected).",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF44336)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton(
                          value: _selectedParam,
                          items: [
                            DropdownMenuItem(
                              child: Text("Breakfast"),
                              value: "Breakfast",
                            ),
                            DropdownMenuItem(
                              child: Text("Lunch"),
                              value: "Lunch",
                            ),
                            DropdownMenuItem(
                              child: Text("Snacks"),
                              value: "Snacks",
                            ),
                            DropdownMenuItem(
                              child: Text("Dinner"),
                              value: "Dinner",
                            ),
                          ],
                          hint: Text(
                            "Select Your Meals",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onChanged: (_val) {
                            setState(() {
                              _selectedParam = _val;
                            });
                          },
                        ),
                        DropdownButton(
                          value: _preference,
                          items: [
                            DropdownMenuItem(
                              child: Text("Non-Veg"),
                              value: "Non-Veg",
                            ),
                            DropdownMenuItem(
                              child: Text("Veg"),
                              value: "Veg",
                            ),
                          ],
                          hint: Text(
                            "Preference",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onChanged: (_val) {
                            setState(() {
                              _preference = _val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Choose Time',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      ),
                      InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          width: _width / 1.7,
                          height: _height / 9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            style: TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                            onSaved: (String val) {
                              print(val);
                              print("val");
                              _setTime = val;
                            },
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: _timeController,
                            decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                // labelText: 'Time',
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: _showNotification,
                      child: Text(
                        "Set Time",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ])),
      ),
    ));
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("You should have $payload"),
      ),
    );
  }
}
