import 'dart:math';

import 'package:lightdisc/components/column_builder.dart';
import 'package:lightdisc/components/player_element.dart';
import 'package:lightdisc/models/player.dart';
import 'package:lightdisc/models/round.dart';
import 'package:lightdisc/views/match_end_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:lightdisc/models/match.dart';

import 'dart:developer';

class MatchView extends StatefulWidget {
  final Match match;

  const MatchView({Key key, this.match}) : super(key: key);

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  Match match;

  int holeIndex = 0;

  int totalPar = 0;
  bool isSwitched = false;
  List<PlayerElement> playerElements = new List<PlayerElement>();

  @override
  Widget build(BuildContext context) {
    buildPlayerElements();
    return gamePanel();
  }

  var borderRadius = 5.0;
  var buttonHeight = 45.0;

  void initState() {
    super.initState();

    match = widget.match;
    match.date = new DateTime.now();



    totalPar = 0;
    // Initialize "round" object for players
    for (int i = 0; i < match.players.length; i++) {
      match.players[i].round = new Round();
      match.players[i].round.deltas = List.filled(30, 0);
      match.players[i].round.holeWins = List.filled(30, 0);
    }
  }

  refreshPlayerElements() {
    // This might be useless function (probably is because of the buildPlayerElements)
    for (int i = 0; i < match.players.length; i++) {
      playerElements[i].setThrows = match.players[i].round.deltas[holeIndex];
    }
  }

  buildPlayerElements() {
    playerElements = new List<PlayerElement>();
    for (int i = 0; i < match.players.length; i++) {
      int diff = 0;
      for (int y = 0; y < match.players[i].round.deltas.length; y++) {
        if (y != holeIndex) diff += match.players[i].round.deltas[y];
      }
      diff -= totalPar;
      int totalWins = 0;
      for (int j = 0; j < match.players[i].round.holeWins.length; j++) {
        totalWins += match.players[i].round.holeWins[j];
      }

      playerElements.add(new PlayerElement(
        key: Key(match.players[i].name + i.toString()),
        name: match.players[i].name,
        deltas: match.players[i].round.deltas[holeIndex],
        wins: totalWins,
        currentPar: 0,
        height: 200, // Useless value
        containerRadius: 0,
        difference: diff,
        numberOfElements: match.players.length,
      ));
    }
  }

  Widget contra() {
    return Container(
      height: 130,
      child: Stack(
        children: [
          Center(
            child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                  TextSpan(text: "HOLE " + (holeIndex + 1).toString()),
                ])),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    inactiveThumbColor: Colors.black,
                    activeTrackColor:
                        Theme.of(context).colorScheme.secondaryVariant,
                    activeColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget gamePanel() {
    return Stack(
      children: [
        Container(
            color: isSwitched == false
                ? holeIndex % 2 != 0
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.secondaryVariant
                : Colors.black54),
        SafeArea(
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isSwitched == false
                          ? holeIndex % 2 != 0
                              ? [
                                  Theme.of(context).colorScheme.error,
                                  Theme.of(context).colorScheme.secondaryVariant
                                ]
                              : [
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                  Theme.of(context).colorScheme.error
                                ]
                          : [Colors.black54, Colors.black54])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new ColumnBuilder(
                        key: Key("column"),
                        mainAxisAlignment: MainAxisAlignment.end,
                        itemCount: match.players.length + 1,
                        itemBuilder: (context, int index) {
                          if (index == 0)
                            return contra();
                          else {
                            final PlayerElement element =
                                playerElements[index - 1];
                            return element;
                          }
                        },
                      ),
                      padding: EdgeInsets.symmetric(vertical: 1),
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 10, top: 10),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        nextHoleButton(),
                        SizedBox(
                          width: 10,
                          height: 5,
                        ),
                        Container(
                          child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                finishMatchButton(),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ButtonTheme(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                            borderRadius)),
                                    height: buttonHeight,
                                    child: OutlineButton(
                                      splashColor: Colors.red[600],
                                      onPressed: () {
                                        previousHole();
                                      },
                                      child: Text("PREV",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  finishMatchAlert() {
    Alert(
        context: context,
        title: "FINISH?",
        type: AlertType.none,
        style: AlertStyle(
          titleStyle:
              TextStyle(color: Theme.of(context).colorScheme.secondaryVariant),
          alertAlignment: Alignment.center,
          isCloseButton: false,
          backgroundColor: Colors.white,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        buttons: [
          DialogButton(
            color: Theme.of(context).colorScheme.onPrimary,
            radius: BorderRadius.circular(borderRadius),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "NAY",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  fontSize: 20),
            ),
          ),
          DialogButton(
            color: Theme.of(context).colorScheme.secondaryVariant,
            radius: BorderRadius.circular(borderRadius),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MatchEnd(match: match)));
            },
            child: Text(
              "YEA",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Widget finishMatchButton() {
    return Expanded(
      child: ButtonTheme(
        height: buttonHeight,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
                color: Colors.white, width: 2, style: BorderStyle.solid),
          ),
          color: Theme.of(context).colorScheme.onPrimary,
          splashColor: Theme.of(context).colorScheme.secondaryVariant,
          onPressed: () {
            finishMatchAlert();
          },
          child: Text("FINISH",
              style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }

  Widget nextHoleButton() {
    return ButtonTheme(
      height: buttonHeight,
      minWidth: MediaQuery.of(context).size.width * 0.90,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
              color: Colors.white, width: 2, style: BorderStyle.solid),
        ),
        color: Theme.of(context).colorScheme.onPrimary,
        splashColor: Theme.of(context).colorScheme.secondaryVariant,
        onPressed: () {
          setState(() {
            nextHole();
          });
        },
        child: Text("NEXT",
            style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).colorScheme.secondaryVariant,
                fontWeight: FontWeight.w400)),
      ),
    );
  }

  saveThrows() {
    for (int i = 0; i < match.players.length; i++) {
      match.players[i].round.deltas[holeIndex] = playerElements[i].deltas;
    }
  }

  getWinner() {
    int lowestScore = 10000;
    int lowestIndex = -1;
    bool lowestFound = false;
    for (int i = 0; i < match.players.length; i++) {
      if (playerElements[i].deltas == lowestScore) {
        lowestFound = false;
      }
      if (playerElements[i].deltas < lowestScore) {
        lowestFound = true;
        lowestIndex = i;
        lowestScore = playerElements[i].deltas;
      }
    }
    if (lowestFound) {
      for (int i = 0; i < match.players.length; i++) {
        if (i == lowestIndex) {
          match.players[i].round.holeWins[holeIndex] = 1;
        } else {
          match.players[i].round.holeWins[holeIndex] = 0;
        }
      }
    } else {
      for (int i = 0; i < match.players.length; i++) {
        match.players[i].round.holeWins[holeIndex] = 0;
      }
    }
  }

  nextHole() {
    if (holeIndex < 30 - 1) {

      saveThrows();

      holeIndex++;

      getWinner();

      setState(() {});
    }
  }

  previousHole() {
    if (holeIndex > 0) {
      saveThrows();

      holeIndex--;

      getWinner();

      setState(() {});
    }
  }
}
