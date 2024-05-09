
import 'package:flutter/material.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';



///THIS CLASS IS THE NAVIGATION BUTTON ON THE TOP LEFT. IT IS IN A SEPARATE CLASS TO IMPLEMENT GAME OVERLAY 

class Navigation extends StatelessWidget {
final GlobalKey<ScaffoldState> scaffoldKey;
final SpaceInvaders? game;

 Navigation({
  required this.scaffoldKey,
   this.game});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
          game?.pauseEngine(); 
          game?.overlays.add('PauseMenu');
        scaffoldKey.currentState!.openDrawer();    //we could declare it here 

      },
      icon: const Icon(
        Icons.menu,
      //Icons.motion_photos_paused_sharp,
        color: Colors.white,
      ),
    );
  }
}
