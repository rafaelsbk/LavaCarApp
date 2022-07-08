import 'package:flutter/material.dart';
import 'package:lavacarapp/pages/login.page.dart';
import 'package:lavacarapp/pages/welcome.page.dart';

void main() => runApp(LavaCarApp());

class LavaCarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LavaCarApp',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: WelcomePage(),
    );
  }
}
