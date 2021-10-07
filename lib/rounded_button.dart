import 'package:food_dating_app/constants.dart';
import 'package:flutter/material.dart';

// try to add a round button
class RoundedBotton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedBotton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        disabledColor: kAccentColor.withOpacity(0.25),
        padding: EdgeInsets.symmetric(vertical: 14),
        highlightElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Text(text, style: Theme.of(context).textTheme.button),
        onPressed: onPressed,
      ),
    );
  }
}
