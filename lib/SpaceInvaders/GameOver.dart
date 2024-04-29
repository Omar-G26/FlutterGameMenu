import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flame/parallax.dart';

import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:gaminghub/SpaceInvaders/SpaceGame.dart';
import 'package:gaminghub/SpaceInvaders/enemy.dart';

class GameOver extends StatelessWidget {
  final SpaceInvaders game;
  //final background game;
  //final SpaceGame game;

  const GameOver({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
          child: Column(
        children: [
          Text('Game Over', style: TextStyle(color: Colors.white)),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            game.removeAll;
            game.startGame(started: true); 
          }, 
          child: Text('Retry?',style: TextStyle(color: Colors.white)))
          ],
      )),
    );
  }
}
