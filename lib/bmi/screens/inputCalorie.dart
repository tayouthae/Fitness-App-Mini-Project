import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'dart:core';
import 'package:miniproject/bmi/bmr_calculator.dart';
import 'package:miniproject/home/home.dart';

class CalorieIntake extends StatefulWidget {
  @override
  _CalorieIntakeState createState() => _CalorieIntakeState();
}

class _CalorieIntakeState extends State<CalorieIntake> {
  final calorie = FirebaseDatabase.instance;
  int height = 0;
  int weight = 0;
  int age = 0;
  String bmr = "0";
  String gender = "Male";

  double _targetCalories = 2250;
  @override
  void initState() {
    super.initState();

    final getData = calorie.reference().child("CalorieCount");
    getData.once().then((DataSnapshot snap) {
      Map<dynamic, dynamic> checkData = snap.value;
      height = checkData['height'];
      weight = checkData['weight'];
      age = checkData['age'];
      gender = checkData['gender'];
    });
   
  }

  Widget build(BuildContext context) {
    final calorieData = calorie.reference().child("details");
    final ref = calorie.reference().child("DailyCalorie");

    BMRcalculator temp =
        BMRcalculator(height: height, weight: weight, gender: gender, age: age);
    temp.calculateBMR();
    bmr = temp.weightLoss();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/calorieBG.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        //Center widget and a container as a child, and a column widget
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
                //Text widget for our app's title
                Text(
                  'Daily Calorie Consumed',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                //space
                SizedBox(height: 20),
                //A RichText to style the target calories
                RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 25),
                      children: [
                        TextSpan(
                            text: _targetCalories.truncate().toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: 'cal',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ]),
                ),
                //Orange slider that sets our target calories
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Colors.lightBlue[100],
                    trackHeight: 6,
                  ),
                  child: Slider(
                    min: 0,
                    max: 4500,
                    value: _targetCalories,
                    onChanged: (value) => setState(() {
                      _targetCalories = value.round().toDouble();
                    }),
                  ),
                ),
                //Simple drop down to select the type of diet
                //Space
                SizedBox(height: 30),
                //FlatButton where onPressed() triggers a function called _searchMealPlan
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //_searchMealPlan function is above the build method
                  onPressed: () {
                    calorieData.push().set({
                      '"Calorie"': bmr,
                    });
                    ref.push().set({
                      '"intake"': _targetCalories,
                    });
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()),
                );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
