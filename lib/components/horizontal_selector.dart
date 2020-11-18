import 'package:flutter/material.dart';

// unused

class HorizontalSelector extends StatefulWidget {
  @override
  _HorizontalSelectorState createState() => _HorizontalSelectorState();
}

class _HorizontalSelectorState extends State<HorizontalSelector> {


  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (details) {
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("yo1 "),
            Text("yo2 "),
            Text("yo3 "),
          ],
        ),
      ),
    );
  }
}

