import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:lightdisc/components/player_card.dart';
import 'package:lightdisc/models/match.dart';
import 'package:lightdisc/models/player.dart';
import 'package:lightdisc/views/match_view.dart';

class MatchSetup extends StatefulWidget {
  @override
  _MatchSetupState createState() => _MatchSetupState();
}

class _MatchSetupState extends State<MatchSetup> {
  Match match = new Match();

  List<PlayerCard> playersListData = List<PlayerCard>();

  addPlayer() {
    setState(() {
      int index = 1;
      for (int i = 0; i < playersListData.length; i++) {
        if (index == playersListData[i].index) {
          index++;
        }
      }
      Player player = new Player("Player " + index.toString(), null,0);
      PlayerCard temp = new PlayerCard(name: player.name, index: index);
      playersListData.add(temp);
      addToMatch(player);
    });
  }

  addHost() {
    setState(() {
      Player player = new Player("You", null,0);
      PlayerCard temp = new PlayerCard(name: player.name, index: 0);
      playersListData.add(temp);
      addToMatch(player);
    });
  }

  addToMatch(Player player) {
    match.players.add(player);
  }


  @override
  void initState() {
    super.initState();
    match = new Match();
    addHost();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAvoider(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Theme.of(context).colorScheme.error,
                Theme.of(context).colorScheme.secondaryVariant
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "PLAYERS"),

                        ])),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemCount: playersListData.length,
                            itemBuilder: (context, index) {
                              final PlayerCard item = playersListData[index];
                              return Dismissible(
                                  background: Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  key: Key(item.name + item.index.toString()),
                                  onDismissed: (direction) {
                                    setState(() {
                                      playersListData.removeAt(index);
                                      match.players.removeAt(index);
                                    });
                                  },
                                  child: playersListData[index]);
                            }),
                      ),
                      (playersListData.length < 4)
                          ? Card(
                              color: Theme.of(context).colorScheme.onPrimary,
                              shape: new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: ListTile(
                                leading: Icon(
                                  Icons.add,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                ),
                                title: Text(
                                  "ADD PLAYER",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryVariant,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () {
                                  addPlayer();
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      height: 45,
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      child: OutlineButton(
                        splashColor: Colors.red[600],
                        child: Text("GO BACK",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    ButtonTheme(
                      height: 45,
                      minWidth: MediaQuery.of(context).size.width * 0.45,
                      buttonColor: Theme.of(context).colorScheme.onPrimary,
                      child: RaisedButton(

                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.onPrimary),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text("START",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                                fontWeight: FontWeight.w600)),
                        onPressed: (){

                                  // Get the changed player properties to the selectedMatch in this loop
                                  for (int i = 0;
                                      i < playersListData.length;
                                      i++) {
                                    match.players[i].name =
                                        playersListData[i].name;
                                  }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MatchView(match: match)));
                              }
,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
