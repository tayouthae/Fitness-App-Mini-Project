import 'package:miniproject/map/map_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(Fifth());

class Fifth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Fifth',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Best Places Near Your'),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: InkWell(
                    child: Container(
                      height: 140.0,
                      width: 410.0,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        image: DecorationImage(
                          image: new AssetImage('assets/Mental/maps.png'),
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
                        MaterialPageRoute(builder: (context) => Maps()),
                      );
                    }),
              ),
              Text('Places Near You', style: TextStyle(fontSize: 23)),
              SizedBox(height: 20),
            ],
          )),
    );
  }
}
