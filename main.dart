import 'package:flutter/material.dart';
import 'package:practiceapp/game_page.dart';

void main() {
  //the main() function is where we set up and start the Flutter application, while runApp() takes care of rendering the UI on the screen.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override //override is a keyword used in Dart programming language to indicate that a method in a child class is intended to replace a method with the same name in its parent class. It helps to avoid errors and makes the code more understandable and maintainable.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Tic Tac Toe Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GamePage(),
    );
  }
}
