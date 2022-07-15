import 'package:miniproject/Diet/Diet1.dart';
import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Second',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Diet Plans'),
        ),
        body: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 250.0,
                width: 500.0,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  image: DecorationImage(
                    image: new AssetImage('assets/Diet/Diet.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 150,
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
                              MaterialPageRoute(builder: (context) => Diet()),
                            );
                          },
                          child: Text(
                            "Weekly Diet".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
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
                              MaterialPageRoute(builder: (context) => Diet()),
                            );
                          },
                          child: Text(
                            "Weight Gain".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 150,
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
                              MaterialPageRoute(builder: (context) => Diet()),
                            );
                          },
                          child: Text(
                            "Weight Lose".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
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
                              MaterialPageRoute(builder: (context) => Diet()),
                            );
                          },
                          child: Text(
                            "Other Diets".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
