import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Maps extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gyms Near You',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gyms Near You'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //GoogleMapController myController;
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);
      LatLng _lastMapPosition = _center;
  final Set<Marker> _markers = {
    Marker(
    markerId: MarkerId('gym1'),
    position: LatLng(19.705498, 72.791168),
    infoWindow: InfoWindow(title: 'Gravity Gym ', snippet: "Cross-Fit"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    ),
  ),
  Marker(
    markerId: MarkerId('gym2'),
    position: LatLng(19.709770, 72.791372),
    infoWindow: InfoWindow(title: 'Bodybuilding Gym ', snippet: "Cardio"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    ),
  ),
  Marker(
    markerId: MarkerId('gym3'),
    position: LatLng(19.713811, 72.795209),
    infoWindow: InfoWindow(title: 'Platinum Gym ', snippet: "Builder"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    ),
  ),
  Marker(
    markerId: MarkerId('gym4'),
    position: LatLng(19.711190, 72.795429),
    infoWindow: InfoWindow(title: 'Gold Gym ', snippet: "Top"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    ),
  ),
  Marker(
    markerId: MarkerId('gym5'),
    position: LatLng(19.708912, 72.794909),
    infoWindow: InfoWindow(title: 'Silver Gym ', snippet: "Best"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    ),
  ),
  Marker(
    markerId: MarkerId('park1'),
    position: LatLng(19.693261, 72.792026),
    infoWindow: InfoWindow(title: 'Nana Nani Park ', snippet: "Enjoy"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  ),
  Marker(
    markerId: MarkerId('park2'),
    position: LatLng(19.693261, 72.802026),
    infoWindow: InfoWindow(title: 'Joggers Park ', snippet: "Walk"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  ),
  Marker(
    markerId: MarkerId('park3'),
    position: LatLng(19.693235, 72.792026),
    infoWindow: InfoWindow(title: 'Morning Park ', snippet: "Run"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  ),
  Marker(
    markerId: MarkerId('park4'),
    position: LatLng(19.69321, 72.792026),
    infoWindow: InfoWindow(title: 'Silence Park ', snippet: "Calm"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  ),
  Marker(
    markerId: MarkerId('park5'),
    position: LatLng(19.693281, 72.792126),
    infoWindow: InfoWindow(title: 'Happy Park', snippet: "Greeny"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  ),
  };

  static final CameraPosition initCameraPosition = CameraPosition(
    target: LatLng(19.7060452,72.7813192),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(19.7060452,72.7813192),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // void _pinHere() {
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId(_lastMapPosition.toString()),
  //       position: _lastMapPosition,
  //       infoWindow: InfoWindow(
  //         title: 'Hello here',
  //         snippet: 'Super!',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }

  void _onCamMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: initCameraPosition,
            compassEnabled: true,
            markers: _markers,
            onCameraMove: _onCamMove,
          ),
        ],
      ),
    );
  }
}