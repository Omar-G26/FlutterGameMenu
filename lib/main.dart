import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';

import 'package:gaminghub/SpaceInvaders/mainMenu.dart';
import 'package:gaminghub/gameNavigation.dart';
import 'package:gaminghub/Navigation.dart';

void main() {
  //runApp(GameWidget(game: SpaceInvaders()));
  runApp(const GameApp());
}

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => GameApp_State();
}

class GameApp_State extends State<GameApp> {
  late GameWidget<SpaceInvaders> plzwork;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget currentChild = Center(child: Text('Game Menu'));

   void changeScreen(Widget newChild) {
    setState(() {
      currentChild = newChild;
    });
  }

  @override
  void initState() {
    super.initState();
    // game1 = SpaceGame();


    ////CHANGE THIS SUCH THAT plzwork CAN BE ASSIGNED WITH ANY GAME OR SOMETHING IN ORDER FOR BUTTON TO WORK
    plzwork = GameWidget<SpaceInvaders>.controlled(
      gameFactory: SpaceInvaders.new,
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
        'GameHub': (_, game) => Navigation(scaffoldKey: scaffoldKey)
      },
      initialActiveOverlays: const ['MainMenu', 'GameHub'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: Scaffold(
            key: scaffoldKey,
            drawer: gameNavigation(context: context, game: plzwork, changeScreen: changeScreen,),
            body: Stack(
              children: [
                Navigation(scaffoldKey: scaffoldKey),
                SafeArea(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child:
                            currentChild  ///This is the current display of the game 
                            ))
              ],
            ))
            );
  }
}
