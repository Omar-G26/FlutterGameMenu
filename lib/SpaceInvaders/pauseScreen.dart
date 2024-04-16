import 'package:flutter/material.dart';

import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';


class PauseScreen extends StatelessWidget {
  final SpaceInvaders game;
  //final background game; 
  //final SpaceGame game; 

  const PauseScreen({required this.game, super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 250,
          width: 300,
   
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PAUSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}