import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttershop/api/profile_api.dart';
import 'package:fluttershop/customer/user.dart';
import 'package:fluttershop/screen/updateUser_screen.dart';
import 'package:fluttershop/screen/utilities/helpers_widget.dart';
import 'package:fluttershop/screen/wishilst_screen.dart';

//import 'updateUser_screen.dart';
//// 'utilities/helpers_widget.dart';
class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  UserProfile userProfile = UserProfile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('أعدادات الحساب'),
          ),
        ),
        body: FutureBuilder(
            future: userProfile.getUserProfile(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return error('no connection made');
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return loding();
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return error(snapshot.error.toString());
                  } else {
                    if (!snapshot.hasData) {
                      return error('no data');
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 22.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
//margin: const EdgeInsets.all(8.0),
                              color: Colors.grey[100],
                              child: Container(
                                width: 355,
                                height: 77,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('البريد الألكتروني'),
                                      Text(snapshot.data.email)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Card(
                              margin:
                                  EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return WishlistScreen( );
                                        },
                                      ),
                                    );
                                    },
                                    title: Text(snapshot.data.first_name,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                    leading: Icon(Icons.account_circle,
                                        color: Colors.black87),
                                    trailing: Icon(Icons.arrow_right,
                                        color: Colors.black87),
                                  ),
                                  _divider(),
                                  ListTile(
                                    onTap: () {},
                                    title: Text(
                                        snapshot.data.latitude.toString(),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                    leading: Icon(Icons.near_me,
                                        color: Colors.black87),
                                    trailing: Icon(Icons.arrow_right,
                                        color: Colors.black87),
                                  ),
                                  _divider(),
                                  ListTile(
                                    onTap: () {},
                                    title: Text('change Location',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                    leading: Icon(Icons.location_on,
                                        color: Colors.black87),
                                    trailing: Icon(Icons.arrow_right,
                                        color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                  color: Colors.red[200],
                                  child: Text('Update'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateUserScreen()));
                                  }),
                            )
                          ],
                        ),
                      );
                    }
                  }
                  break;
              }
              return Container();
            }));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
