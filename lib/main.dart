import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';

import 'package:gaminghub/SpaceInvaders/mainMenu.dart';
import 'package:gaminghub/SpaceInvaders/SpaceGame.dart';

void main() {

  //runApp(GameWidget(game: SpaceInvaders()));

   runApp(
    GameWidget<SpaceInvaders>.controlled(
      gameFactory: SpaceInvaders.new,
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
     //   'GameOver': (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: const ['MainMenu'],

    ),
  );

  //  runApp(
  //   GameWidget<SpaceGame>.controlled(
  //     gameFactory: SpaceGame.new,
  //     overlayBuilderMap: {
  //       'MainMenu': (_, game) => MainMenu(game: game),
  //    //   'GameOver': (_, game) => GameOver(game: game),
  //     },
  //     initialActiveOverlays: const ['MainMenu'],
  //   ),
  // );

  //runApp(MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: const Center(
        
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    
    );
  }
}
