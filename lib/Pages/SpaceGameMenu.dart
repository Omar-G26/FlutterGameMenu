
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gaminghub/ScoreHandler/scoreData.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:gaminghub/SpaceInvaders/GameOver.dart';
import 'package:gaminghub/SpaceInvaders/pauseScreen.dart';

import 'package:gaminghub/SpaceInvaders/mainMenu.dart';
import 'package:gaminghub/gameNavigation.dart';
import 'package:gaminghub/Navigation.dart';
import 'package:gaminghub/Pages/GameSelectionPage.dart';




class SpaceInvadersPage extends StatefulWidget {
 SpaceInvadersPage({Key? key,required}) : super(key: key);

  @override
  _SpaceInvadersPageState createState() => _SpaceInvadersPageState();
}

class _SpaceInvadersPageState extends State<SpaceInvadersPage> {
  late GameWidget<SpaceInvaders> plzwork;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget currentChild = Center(child: Text('Game Menu'));

  bool isDrawerOpen = false;

  void changeScreen(Widget newChild) {
    setState(() {
      currentChild = newChild;
    });
  }

  @override
  void initState() {
    super.initState();
    plzwork = GameWidget<SpaceInvaders>.controlled(
      gameFactory: () => SpaceInvaders(),
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
        'GameHub': (_, game) => Navigation(
              scaffoldKey: scaffoldKey,
              game: game,
            ),
        'GameOver': (_, game) => GameOver(game: game),
        'PauseMenu': (_, game) => PauseScreen(game: game),
        
      },
      initialActiveOverlays: const ['MainMenu', 'GameHub'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: Scaffold(
           key: scaffoldKey,         //For game overlay                                                
           drawer: gameNavigation(context: context, game: plzwork, changeScreen: changeScreen,),  //For game Overlay
            body: Stack(
              children: [
               // plzwork,
                Navigation(scaffoldKey: scaffoldKey),
                SafeArea(
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                   plzwork ///This is the current display of the game 
                    )),

                // if (!isDrawerOpen)
                //   Positioned(
                //     top: 0,
                //     left: 0,
                //     bottom: 0,
                //     child: gameNavigation(
                //       game: plzwork,
                //       context: context,
                //       changeScreen: changeScreen,
                //     ), // Display the gameNavigation drawer
                //   ),
              ]
            ),
            // appBar: AppBar(
            //   title: Text('Game Home'),
            //   leading: IconButton(
            //     icon: Icon(Icons.menu),
            //     onPressed: () {
            //       setState(() {
            //         isDrawerOpen = !isDrawerOpen; // Toggle the state of the drawer
            //       });
            //     },
            //   ),
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                 Navigator.of(context).pop(); // Navigate back to the previous page
            
              },
              child: Icon(Icons.home),
            ),
      ),
    );
  }
}