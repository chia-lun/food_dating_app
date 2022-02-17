import 'package:flutter/material.dart';


class _DismissKeyboardTutorialScreenState
    
  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    focusNode.addListener(() {
      print('Listener');
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              autofocus: true,
              focusNode: focusNode,
            ),
          ),
          RaisedButton(
            onPressed: () {
              showKeyboard();
            },
            child: Text('Show Keyboard'),
          ),
          RaisedButton(
            onPressed: () {
              dismissKeyboard();
            },
            child: Text('Dismiss Keyboard'),
          ),
        ],
      ),
    );
  }

  void showKeyboard() {
    focusNode.requestFocus();
  }

  void dismissKeyboard() {
    focusNode.unfocus();
  }
}

