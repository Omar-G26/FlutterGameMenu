
import 'package:flutter/material.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:flame/game.dart';


import 'package:gaminghub/isActive.dart';


///THIS CLASS IS THE NAVIGATION BUTTON ON THE TOP LEFT. IT IS IN A SEPARATE CLASS TO IMPLEMENT GAME OVERLAY 

//Might need to declared Navigation classes for each game cause flutter is retarded 
class Navigation extends StatelessWidget {
final GlobalKey<ScaffoldState> scaffoldKey;
final SpaceInvaders? game;

  const Navigation({required this.scaffoldKey, this.game});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();    //we could declare it here 
        
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }
}
