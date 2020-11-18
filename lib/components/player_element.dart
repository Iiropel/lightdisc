import 'dart:math';

import 'package:lightdisc/components/throw_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'horizontal_selector.dart';

class PlayerElement extends StatefulWidget {
  // ignore: must_be_immutable
  final double containerRadius;
  final double height;
  final int numberOfElements;
  final String name;
  final int currentPar;
  int difference;
  int deltas;
  int wins;

  PlayerElement(
      {Key key,
      this.wins,
      this.containerRadius,
      this.height,
      this.name,
      this.numberOfElements,
      this.deltas,
      this.difference,
      this.currentPar})
      : super(key: key);

  set setThrows(int throws) {
    this.deltas = throws;
  }

  int getThrows() {
    return deltas;
  }

  @override
  _PlayerElementState createState() => _PlayerElementState();
}

class _PlayerElementState extends State<PlayerElement> {
  double headerFontSize = 20.0;
  double parFontSize = 20.0;
  double buttonSize = 20.0;

  int value = 0;

  double pointerXPos = 0;

  scaleSubElements() {
    switch (widget.numberOfElements) {
      case 1:
        headerFontSize = 40;
        parFontSize = 20;
        buttonSize = 50;
        break;
      case 2:
        headerFontSize = 30;
        parFontSize = 20;
        buttonSize = 30;
        break;
      case 3:
        headerFontSize = 25;
        parFontSize = 20;
        buttonSize = 20;
        break;
      default:
        break;
    }
  }

  changePar(int change) {
    widget.deltas += change;
    if (widget.deltas < -3) widget.deltas = -3;
    if (widget.deltas > 20) widget.deltas = 20;
  }

  @override
  void initState() {
    super.initState();
    scaleSubElements();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(100),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: headerFontSize, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      changePar(-1);
                    });
                  },
                  child: new Icon(
                    Icons.remove,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: buttonSize,
                  ),
                  elevation: 0,
                  fillColor: Colors.transparent,
                  padding: const EdgeInsets.all(15.0),
                ),
                Listener(
                  onPointerDown: (details) {},
                  onPointerMove: (details) {
                    setState(() {
                      pointerXPos = details.position.dx -
                          (MediaQuery.of(context).size.width / 2);
                    });
                  },
                  child: Text(
                    getScoreName(widget.deltas),
                    style: TextStyle(
                        fontSize: parFontSize, fontWeight: FontWeight.w600),
                  ),
                ),
                new RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      changePar(1);
                    });
                  },
                  child: new Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: buttonSize,
                  ),
                  elevation: 0,
                  fillColor: Colors.transparent,
                  padding: const EdgeInsets.all(0.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      ((widget.difference + widget.deltas != 0)
                              ? (widget.difference + widget.deltas).toString()
                              : "E") +
                          "(" +
                          ((widget.deltas > 0)
                              ? "+" + widget.deltas.toString()
                              : widget.deltas.toString()) +
                          ")",
                      style: TextStyle(
                          fontSize: headerFontSize, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Container(
                  height: widget.numberOfElements > 4 ? 15 : 25,
                  width: 1,
                  color: Colors.white.withAlpha(100),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.wins.toString(),
                      style: TextStyle(
                          fontSize: headerFontSize, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
            widget.numberOfElements > 2
                ? Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  )
                : Container(
                    height: 0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        width: MediaQuery.of(context).size.width,
        height: 200,
        margin: EdgeInsets.only(bottom: 2),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      ),
    );
  }

  String getScoreName(int delta) {
    var scoreName;
    switch (delta) {
      case 5:
        scoreName = "PENTA BOGEY";
        break;
      case 4:
        scoreName = "QUAD BOGEY";
        break;

      case 3:
        scoreName = "TRIPLE BOGEY";
        break;

      case 2:
        scoreName = "DOUBLE BOGEY";
        break;

      case 1:
        scoreName = "BOGEY";
        break;

      case 0:
        scoreName = "PAR";
        break;

      case -1:
        scoreName = "BIRDIE";
        break;

      case -2:
        scoreName = "EAGLE";
        break;
      case -3:
        scoreName = "ALBATROSS";
        break;
      default:
        scoreName = "YIKES";
        break;
    }
    return scoreName;
  }

  _buildAlert2() {
    Alert(
        context: context,
        title: widget.name,
        type: AlertType.none,
        style: AlertStyle(
          animationType: AnimationType.grow,
          titleStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          isCloseButton: false,
          backgroundColor: Colors.transparent,
          overlayColor: Colors.black,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        content: HorizontalSelector(),
        buttons: []).show();
  }
}
