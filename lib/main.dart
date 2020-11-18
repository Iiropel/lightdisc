import 'package:flutter/material.dart';
import 'package:lightdisc/views/mainmenu_view.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData td = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.grey[900],
      primaryVariant: Colors.black45,
      secondary: Colors.deepOrange,
      secondaryVariant: Colors.pink[700],
      onSecondary: Colors.white,
      onPrimary: Colors.white,
      surface: Colors.white10,
      background: Colors.white10,
      onBackground: Colors.white,
      error: Colors.red,
      onError: Colors.black,
      onSurface: Colors.white,

    ),
    cursorColor: Colors.white,
    hintColor: Colors.white,
    brightness: Brightness.dark,
    backgroundColor: Colors.black87,
    toggleableActiveColor: Colors.deepOrange,
    unselectedWidgetColor: Colors.white,
    primarySwatch: Colors.red,
    textSelectionHandleColor: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lightdisc',
      theme: td,
      home: MainMenu(),
    );
  }
}
