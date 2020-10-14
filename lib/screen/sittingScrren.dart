import 'package:flutter/material.dart';

class SettingScrren extends StatefulWidget {
  @override
  _SettingScrrenState createState() => _SettingScrrenState();
}

class _SettingScrrenState extends State<SettingScrren> {

  _divider(){
   return 
    Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              width: double.infinity,
              height: 1.0,
              color: Colors.grey.shade300,
            );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title:Text('setting'),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.all(8.0),
            color: Colors.purple,
            child: ListTile(
              onTap: (){
              
              },
              title: Text('ali majed',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              leading: Icon(Icons.account_circle,color:Colors.white),
              trailing: Icon(Icons.mode_edit,color:Colors.white),
            ),
          ),
          const SizedBox(height: 10.0,),
          Card(
            margin: EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: [
               ListTile(
              onTap: (){},
              title: Text('ali majed',style:TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
              leading: Icon(Icons.account_circle,color:Colors.black87),
              trailing: Icon(Icons.arrow_right,color:Colors.black87),
            ),
           _divider(),
              ListTile(
              onTap: (){},
              title: Text('ali majed',style:TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
              leading: Icon(Icons.near_me,color:Colors.black87),
              trailing: Icon(Icons.arrow_right,color:Colors.black87),
            ),
            _divider(),
              ListTile(
              onTap: (){},
              title: Text('change Location',style:TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
              leading: Icon(Icons.location_on,color:Colors.black87),
              trailing: Icon(Icons.arrow_right,color:Colors.black87),
            ),
            ],
          ),
          
          )
        ],
      ),
    );
  }
}
