import 'dart:ffi';

import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedOutlinedButton({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
        //highlightedBorderColor: Colors.orange,
        //borderSide: BorderSide(color: Colors.orange, width: 2.0),
        child: Text(text, style: Theme.of(context).textTheme.button),
        onPressed: () {},
        //shape: RoundedRectangleBorder(
        //borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
