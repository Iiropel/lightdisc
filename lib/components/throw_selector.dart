import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector, Vector2, radians, radians2Degrees;

// unused

// ignore: must_be_immutable
class ThrowSelector extends StatefulWidget {
  int throws;
  int value;

  ThrowSelector({Key key, this.throws, this.value}) : super(key: key);
  @override
  _ThrowSelectorState createState() => _ThrowSelectorState();
}

class _ThrowSelectorState extends State<ThrowSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Listener(
        onPointerUp: (details)
        {
          setState(() {
          });
        },
        onPointerMove: (details)
        {
          widget.value = 0;
          double xPos = details.position.dx-(MediaQuery.of(context).size.width/2);
          double yPos = details.position.dy-(MediaQuery.of(context).size.height/2);
          Vector2 pointerFromCenter = new Vector2(xPos, yPos);
          Vector2 vectorRight = new Vector2(1, 0);
          double angle = pointerFromCenter.angleToSigned(vectorRight) * radians2Degrees;
          if(angle<0)
          {
            angle += 360.0;
          }
          if (angle < 90.0 && angle > 20.0)
          {
            widget.value = 2;
          }
          if (angle < 160.0 && angle > 90.0)
          {
            widget.value = 1;
          }
          if (angle < 220.0 && angle > 160.0)
          {
            widget.value = 6;
          }
          if (angle < 270.0 && angle > 220.0)
          {
            widget.value = 5;
          }
          if (angle < 320.0 && angle > 270.0)
          {
            widget.value = 4;
          }
          if (angle < 20.0 && angle > 0.0 || angle > 320.0 && angle < 360.0)
          {
            widget.value = 3;
          }
          setState(() {
          });
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _changeThrowsButton(1,widget.value),
                _changeThrowsButton(2,widget.value),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _changeThrowsButton(6,widget.value),
                _changeThrowsButton(7,widget.value,visible: false),

                _changeThrowsButton(3,widget.value),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _changeThrowsButton(5,widget.value),
                _changeThrowsButton(4,widget.value),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _changeThrowsButton(int number, int value, {bool visible = true}) {

    Color color = Colors.transparent;
    if(number == widget.value)
    {
      color = Theme.of(context).colorScheme.secondary;
    }

    return new RawMaterialButton(
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(15.0),
      hoverColor: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        setState(() {
          widget.throws = number;
        });
        Navigator.pop(context);} ,
      child: Text(
        number.toString(),
        style: TextStyle(
            color: (visible == true) ? Theme.of(context).colorScheme.onPrimary : Colors.transparent, fontSize: 20),
      ),
    );

  }
}
