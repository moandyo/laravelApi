import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocaitionScreen extends StatefulWidget {
  @override
  _LocaitionScreenState createState() => _LocaitionScreenState();
}

class _LocaitionScreenState extends State<LocaitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('locaition')),
      body: Center(
        child: IconButton(icon: Icon(Icons.pan_tool), onPressed: ()async{
           Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
           print(position.latitude);
           print(position.longitude);
        }),
      ),
    );
  }
}