// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({
    Key key,
    this.index,
    this.name,
  }) : super(key: key);

  String name;
  final int index;
  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  String name;

  @override
  void initState() {
    super.initState();
    name = widget.name;
  }

  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = new TextEditingController(text: widget.name);
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          borderRadius: BorderRadius.circular(5.0)),
      child: ListTile(
        leading: Icon(Icons.person),
        title: new Container(
          width: 150.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  onChanged:  (value) {
    widget.name = value;},
                  textAlign: TextAlign.start,
                  onSubmitted: (value) {
                    widget.name = value;
                  },
                  decoration:
                      new InputDecoration.collapsed(hintText: widget.name),
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
