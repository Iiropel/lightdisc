import 'package:flutter/material.dart';

class HoleResult extends StatefulWidget {
  final int holeNumber;
  final int holePar;
  final List<int> holeResults;

  const HoleResult({Key key, this.holeNumber, this.holePar, this.holeResults})
      : super(key: key);
  @override
  _HoleResultState createState() => _HoleResultState();
}

class _HoleResultState extends State<HoleResult> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 65,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.holeNumber.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text("Par " + widget.holePar.toString()),
                    ],
                  )),
              VerticalDivider(
                color: Colors.white,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                child: Center(child: (widget.holeResults.length >= 1)
                    ? Text(widget.holeResults[0].toString())
                    : Text(""),),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                child: Center(child: (widget.holeResults.length >= 2)
                    ? Text(widget.holeResults[1].toString())
                    : Text(""),),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                child: Center(child: (widget.holeResults.length >= 3)
                    ? Text(widget.holeResults[2].toString())
                    : Text(""),),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                child: Center(child: (widget.holeResults.length >= 4)
                    ? Text(widget.holeResults[3].toString())
                    : Text(""),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
