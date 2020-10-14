import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttershop/pages/account.dart';
import 'package:fluttershop/pages/bay.dart';
import 'package:fluttershop/pages/homeScreen.dart';
import 'package:fluttershop/pages/home.dart';
import 'package:fluttershop/pages/category_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;
   List<Widget> _widgetOptions = <Widget>[
    Account(),
    HomeScreen1(),
     HomeScreen(),
   // HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _widgetOptions.elementAt(_selectedIndex),
        Positioned(
          height: 50,
            left: 0,
            right: 0,
            bottom: 0,
            child:  ClipRRect(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(19),
        topLeft: Radius.circular(19),
      ),
              child: BottomNavigationBar(
                //showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                 icon: Icon(EvaIcons.home),
                 title: SizedBox(width: 0,height: 0,),
              ),
              BottomNavigationBarItem(
              icon: Icon(EvaIcons.calendarOutline),
             title: SizedBox(width: 0,height: 0,),
              ),
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.gridOutline),
                title: SizedBox(width: 0,height: 0,),
              ),
            //  BottomNavigationBarItem(
             //   icon: Icon(Icons.access_alarm),
             ///   title: Text('1'),
            //  ),
            ],
            currentIndex: _selectedIndex,
            backgroundColor: Color.fromARGB(255, 58, 52, 64),
            
            selectedItemColor: Colors.red,unselectedItemColor: Colors.grey,
            onTap: _onItemTapped),
        ),
          ),
      ],),
    
    );
  }
}

Widget get bottomNavBar{
  return ClipRRect(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
              child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                 icon: Icon(Icons.access_alarm),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
                title: Text('Mentors'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm),
                title: Text('Messages'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm),
                title: Text('Settings'),
              ),
            ],
        //    currentIndex: _selectedIndex,
            backgroundColor: Colors.amber,
            
            selectedItemColor: Colors.blue,
          //  onTap: _onItemTapped),
        
      ));
}
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 3;

  final Account _account = Account();
  final HomeScreen1 _homeScreen1 = HomeScreen1(); //االصفحة الاوله
  final HomeScreen _homeScreen = HomeScreen();
  final Bay _pay = Bay();
  //final CategoryP _categoryp= CategoryP();
  //GlobalKey _bottomNavigationKey = GlobalKey();
  Widget _showPages = HomeScreen();
  Widget _pageChoser(int page) {
    switch (page) {
      case 0:
        return _account;
        break;
      case 1:
        return _homeScreen1;
        break;

      case 2:
        return _pay;
        break;

      case 3:
        return _homeScreen;
        break;

      //  case 4:
      //return _categoryp;
      //break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          // key: _bottomNavigationKey,
          index: pageIndex,
          height: 48.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.dashboard, size: 30),
            Icon(Icons.delete, size: 30),
            Icon(Icons.menu, size: 30),
            // Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.grey[100],
          backgroundColor: Colors.indigo[50],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _showPages = _pageChoser(index);
            });
          },
        ),
        body: Center(
          child: Container(color: Colors.blueAccent, child: _showPages),
        ));
  }
}
