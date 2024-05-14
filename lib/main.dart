import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/ScorePage.dart';
import 'package:gaminghub/Pages/GameHomePage.dart';
import 'package:gaminghub/ScoreHandler/scoreData.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Scores(),
      child: const GameApp(),
    ),
  );
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const GameHomePage(),
      routes: {
        '/scores': (context) => const ScoresPage(),
      },
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
/* 

class ScoresPage extends StatelessWidget {
  const ScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scores = Provider.of<Scores>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Space Shooter High Score: ${scores.getTetrisHighScore()}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Tetris High Score: ${scores.getSpaceShooterHighScore()}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}


 */