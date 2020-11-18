import 'package:lightdisc/models/player.dart';

class Match {
  Match() {
    this.date = DateTime.now();
    this.duration = 0;
    this.courseLength = 0;
    this.players = new List<Player>();
  }

  DateTime date;
  int duration;
  int courseLength;
  List<Player> players;
}
