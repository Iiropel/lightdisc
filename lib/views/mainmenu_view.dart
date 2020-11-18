import 'package:flutter/material.dart';
import 'package:lightdisc/components/bubbles.dart';
import 'package:lightdisc/views/matchsetup_view.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
          Theme.of(context).colorScheme.error,
          Theme.of(context).colorScheme.secondaryVariant
        ])),
        child: Stack(
      children: [Bubbles(),
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                  TextSpan(text: "LITE"),
                  TextSpan(
                    text: "DISC",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ])),
            SizedBox(height: 10),
            ButtonTheme(
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.70,
              child: OutlineButton(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                child: Text(
                  "HISTORY",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                onPressed: () {
                },
              ),
            ),
            SizedBox(height: 10),
            ButtonTheme(
              height: MediaQuery.of(context).size.height * 0.1,
              minWidth: MediaQuery.of(context).size.width * 0.70,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              child: RaisedButton(
                padding: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text(
                  "PLAY",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondaryVariant),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MatchSetup()));
                },
              ),
            ),
          ],
        ),
      )],
        ),
      ),
    );
  }
}
