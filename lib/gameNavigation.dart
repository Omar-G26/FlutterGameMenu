import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';

import 'package:flutter/material.dart';
import 'package:gaminghub/isActive.dart';

//extends StatelessWidget
class gameNavigation extends StatelessWidget {
  final BuildContext context;
  final GameWidget<SpaceInvaders> game;
  final void Function(Widget newChild) changeScreen;
  //isActive gameStatus; 

  gameNavigation(
      {required this.game,
      required this.context,
      required this.changeScreen,
    //  required this.gameStatus, 
      super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Stack(children: [
        //  SizedBox(height: 30  , width: 30, child:
        Drawer(
            child: Center(
                child: ListView(
      children: [
        SizedBox(height: 30),
        Center(child: Text('Game Menu',style: TextStyle(fontSize: 30 ))),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // print('is working???111 ${gameStatus?.getActive()}');
            // gameStatus?.setActive(true); 
            // print('is working??? ${gameStatus?.getActive()}');
           // gameStatus.setGame(game);
            changeScreen(game);
          },
          child: Text('Space Game'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Tic Tac Toe'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Tetris'),
        ),
      ],
    )));
  }
}
