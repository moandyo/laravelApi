import 'package:flutter/material.dart';

Widget loding(){
  return Container(
    //color: Colors.white,
    child: Center(
      child:CircularProgressIndicator(   strokeWidth: 1.0,)
    ),
  );
}

Widget error(String error){
  return Container(
    child: Center(
      child: Text(
        error,
        style:TextStyle(
          color: Colors.red
        ),
      ),
    ),
  );
}