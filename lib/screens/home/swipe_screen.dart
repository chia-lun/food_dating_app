import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/swipe.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:food_dating_app/widgets/custom_modal.dart';
import 'package:food_dating_app/widgets/swipe_card.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final DatabaseService db =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _ignoreSwipeIds = [];

  late GoogleMapController mapController;

  Future<List<AppUser>> loadPeople() async {
    return await db.userListFromSnapShots();
  }

  Future<bool> isMatch(AppUser otherUser) async {
    DocumentSnapshot swipeSnapshot = await db.getSwipe(otherUser.uid);
    if (swipeSnapshot.exists) {
      Swipe swipe = Swipe.fromSnapshot(swipeSnapshot);

      if (swipe.liked == true) {
        return true;
      }
    }
    return false;
  }

  // Decimal Degrees format
  final LatLng _center = const LatLng(44.9374234, -93.1692095);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
        home: Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 17.0),
          ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return FutureBuilder<AppUser>(
                future: authProvider.user,
                builder: (context, userSnapshot) {
                  return CustomModalProgressHUD(
                    inAsyncCall: authProvider.user == null,
                    child: (userSnapshot.hasData)
                        ? FutureBuilder<List<AppUser>>(
                            future: loadPeople(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.data == null) {
                                return Center(
                                  child: Text('No users',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                );
                              }
                              if (!snapshot.hasData) {
                                return CustomModalProgressHUD(
                                  inAsyncCall: true,
                                  child: Container(),
                                );
                              }
                              return Padding(
                                padding: EdgeInsets.fromLTRB(20, 90, 1, 1),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    verticalDirection: VerticalDirection.up,
                                    children: <Widget>[
                                      Stack(
                                          children: snapshot.data!
                                              .map((user) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    child: SwipeCard(
                                                      user: user,
                                                    ),
                                                  ))
                                              .toList()),
                                    ]),
                              );
                            })
                        : Container(),
                  );
                },
              );
            },
          )
        ],
      ),
    ));
  }
}
