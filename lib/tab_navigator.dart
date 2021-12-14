import 'package:flutter/material.dart';
import 'package:food_dating_app/models/swipe.dart';
import 'package:food_dating_app/screens/home/home_page.dart';
import 'package:food_dating_app/screens/home/message_page.dart';
import 'package:food_dating_app/screens/home/profile_page.dart';
import 'package:food_dating_app/screens/home/swipe_screen.dart';

class TabNavigator extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child = SwipeScreen();
    if (tabItem == "SwipePage") {
      child = SwipeScreen();
    } else if (tabItem == "Messages") {
      child = MessagePage();
    } else if (tabItem == "Profile") {
      child = ProfilePage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
