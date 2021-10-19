import 'package:flutter/material.dart';
import 'package:food_dating_app/views/home_page.dart';
import 'package:food_dating_app/views/message_page.dart';
import 'package:food_dating_app/views/profile_page.dart';

class TabNavigator extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child = HomePage();
    if (tabItem == "Home") {
      child = HomePage();
    } else if (tabItem == "Messages") {
      child = MessagePage();
    } else if (tabItem == "Profiles") {
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
