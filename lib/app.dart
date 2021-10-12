import 'package:flutter/material.dart';
//import 'package:persistent_bottom/tab_navigator.dart';
//import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';
//import 'package:custom_navigator/custom_scaffold.dart';
import 'package:food_dating_app/tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Messages", "Profiles"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Messages": GlobalKey<NavigatorState>(),
    "Profiles": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 1);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
          child: Scaffold(
        body: Stack(
          children:<Widget>[
            _buildOffstageNavigator("Home"),
            _buildOffstageNavigator("Messages"),
            _buildOffstageNavigator("Profiles"),
          ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange,
          onTap: (int index) { _selectTab(pageKeys[index], index); },
          currentIndex: _selectedIndex, 
          items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profiles',
          ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
   
  }

  Widget _buildOffstageNavigator(String tabItem) {
      return Offstage(
        offstage: _currentPage != tabItem,
        child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem]!,
          tabItem: tabItem,
        ),
      );
  
  }
}
