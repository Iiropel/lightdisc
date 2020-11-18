import 'package:lightdisc/models/round.dart';

class Player {
  Player(String name, Round round,int holeWins) {
    this.name = name;
    this.round = round;
  }
  String name;
  Round round;
}
