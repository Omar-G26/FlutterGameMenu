import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:gaminghub/SpaceInvaders/GameOver.dart';
import 'package:gaminghub/SpaceInvaders/pauseScreen.dart';

import 'package:gaminghub/SpaceInvaders/mainMenu.dart';
import 'package:gaminghub/gameNavigation.dart';
import 'package:gaminghub/Navigation.dart';

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

class GameHomePage extends StatelessWidget {
  const GameHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameSelectionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Adjust the size here
              ),
              child: const Text('Play'),
            ),
            const SizedBox(height: 16), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Handle settings button press
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Adjust the size here
              ),
              child: const Text('Settings'),
            ),
            const SizedBox(height: 16), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Handle scores button press
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScoresPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Adjust the size here
              ),
              child: const Text('Scores'),
            ),
          ],
        ),
      ),
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

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: const Text('settings'),
      ),
    );
  }
}

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

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Space Invaders
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SpaceInvadersPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Adjust the size here
              ),
              child: const Text('Space Invaders'),
            ),
            const SizedBox(height: 16), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Tic Tac Toe
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicTacToePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Adjust the size here
              ),
              child: const Text('Tic Tac Toe'),
            ),
            const SizedBox(height: 16), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Tetris
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TetrisPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Adjust the size here
              ),
              child: const Text('Tetris'),
            ),
          ],
        ),
      ),
    );
  }
}

class SpaceInvadersPage extends StatefulWidget {
  const SpaceInvadersPage({Key? key}) : super(key: key);

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
             // scaffoldKey: scaffoldKey,
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: Scaffold(
         //  key: scaffoldKey,         //For game overlay                                                
         //  drawer: gameNavigation(context: context, game: plzwork, changeScreen: changeScreen,),  //For game Overlay
            body: Stack(
              children: [
               // plzwork,
              //  Navigation(scaffoldKey: scaffoldKey),
                SafeArea(
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:
                   plzwork ///This is the current display of the game 
                    )),

                if (!isDrawerOpen)
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: gameNavigation(
                      game: plzwork,
                      context: context,
                      changeScreen: changeScreen,
                    ), // Display the gameNavigation drawer
                  ),
              ]
            ),
            appBar: AppBar(
              title: Text('Game Home'),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    isDrawerOpen = !isDrawerOpen; // Toggle the state of the drawer
                  });
                },
              ),
            ),
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

class TicTacToePage extends StatelessWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
      ),
      body: Center(
        child: const Text('Game'),
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
