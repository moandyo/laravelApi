import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../accountScreen.dart';
import '../wishilst_screen.dart';

Widget drawer(context){
  return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: null, 
        accountEmail: null),
        
        Container(
      color: Colors.blueGrey[600],
      width: MediaQuery.of(context).size.width *0.50,
      height: MediaQuery.of(context).size.height *0.90,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text('حسابي'),
              trailing: Icon(Icons.arrow_back),
              onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountScreen()));
              },
            ),
          ),

           ListTile(
            leading: Icon(Icons.account_box),
            title: Text('حسابي'),
            trailing: Icon(Icons.arrow_back),
            onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountScreen()));
            },
          ),

           ListTile(
            leading: Icon(Icons.account_box),
            title: Text('الشراء لاحقا'),
            trailing: Icon(Icons.arrow_back),
            onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>WishlistScreen()));
            },
          ),
        ],
      ),
    ),
   ],
  );
}