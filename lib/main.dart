import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/GameHomePage.dart';
import 'package:gaminghub/path/backgroundAssets.dart';




void main() {   
  runApp(const GameApp());
}


class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Set brightness to dark
      ),
      home: const GameHomePage(),
    );
  }
}


/*class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Page'),
      ),
      body: Center(
        child: const Text('Hello'),
      ),
    );
  }
}
*/


class ScoresPage extends StatelessWidget {
  const ScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Center(
        child: const Text('High Score!'),
      ),
    );
  }
}

class TetrisPage extends StatelessWidget {
  const TetrisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tetris'),
      ),
      body: Center(
        child: const Text('Game'),
      ),
    );
  }
}
