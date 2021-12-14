import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:food_dating_app/models/app_user.dart';

class SwipeCard extends StatefulWidget {
  final AppUser? user;

  SwipeCard({required this.user});

  @override
  // ignore: no_logic_in_create_state
  _SwipeCardState createState() => _SwipeCardState(
        user: user,
      );
}

class _SwipeCardState extends State<SwipeCard> {
  _SwipeCardState({required this.user});
  AppUser? user;

  @override
  Widget build(BuildContext context) {
    return Swipable(
      //horizontalSwipe: false,
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: Image.network(user!.getURL()).image,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              //child: Text(title.toString()),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.getName(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.getAge().toString(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.getRestaurant(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      onSwipeLeft: (finalPosition) {
        //personSwiped(convertCurrentUser(), otherUser, true);
      },
      onSwipeRight: (finalPosition) {
        //personSwiped(convertCurrentUser(), otherUser, false);
      },
    );
  }
}
