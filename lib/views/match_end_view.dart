import 'package:lightdisc/components/hole_result_element.dart';
import 'package:lightdisc/models/match.dart';
import 'package:flutter/material.dart';
import 'package:lightdisc/models/player.dart';

class MatchEnd extends StatefulWidget {
  final Match match;

  const MatchEnd({Key key, this.match}) : super(key: key);
  @override
  _MatchEndState createState() => _MatchEndState();
}

class _MatchEndState extends State<MatchEnd> {
  Match match;
  List<HoleResult> results;
  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  Widget playerCard(Player player) {
    int totalWins = 0;
    for (int i = 0; i < player.round.holeWins.length; i++) {
      totalWins += player.round.holeWins[i];
    }
    int totalScore = 0;
    for (int i = 0; i < player.round.deltas.length; i++) {
      totalScore += player.round.deltas[i];
    }
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          borderRadius: BorderRadius.circular(5.0)),
      child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Container(width: 80,child: Text(player.name)),
              Expanded(child: Center(child: Text("SCORE: " + totalScore.toString()))),
              Text("HOLE WINS: " + totalWins.toString()),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> players = List<Widget>();
    for (int i = 0; i < match.players.length; i++) {
      players.add(playerCard(match.players[i]));
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                    TextSpan(text: "GAME"),
                    TextSpan(
                      text: "OVER",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary),
                    )
                  ])),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        return players[index];
                      }),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: ButtonTheme(
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width * 0.90,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                          color: Colors.white, width: 2, style: BorderStyle.solid),
                    ),
                    color: Theme.of(context).colorScheme.onPrimary,
                    splashColor: Theme.of(context).colorScheme.secondaryVariant,
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text("MENU",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
