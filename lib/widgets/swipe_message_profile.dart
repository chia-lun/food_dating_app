import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_dating_app/tab_navigator.dart';

class SwipeMessageProfile extends StatefulWidget {
  const SwipeMessageProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SwipeMessageProfileState();
}

class SwipeMessageProfileState extends State<SwipeMessageProfile> {
  String _currentPage = "SwipePage";
  List<String> pageKeys = ["SwipePage", "Messages", "Profile"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "SwipePage": GlobalKey<NavigatorState>(),
    "Messages": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
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
          if (_currentPage != "SwipePage") {
            _selectTab("SwipePage", 1);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("SwipePage"),
          _buildOffstageNavigator("Messages"),
          _buildOffstageNavigator("Profile"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Swipe',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger, size: 27),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind, size: 27),
              label: '',
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
