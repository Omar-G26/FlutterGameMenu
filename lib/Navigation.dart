
import 'package:flutter/material.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:flame/game.dart';



///THIS CLASS IS THE NAVIGATION BUTTON ON THE TOP LEFT. IT IS IN A SEPARATE CLASS TO IMPLEMENT GAME OVERLAY 
class Navigation extends StatelessWidget {
final GlobalKey<ScaffoldState> scaffoldKey;
final GameWidget<SpaceInvaders>? game;

  const Navigation({required this.scaffoldKey, this.game});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
       // game?.game.pauseEngine();
        
      },
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }
}
