import 'package:flutter/material.dart';

import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';


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
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 350,
          width: 300,
   
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: 'retro'
                ),
              ),
              const SizedBox(height: 10),
               Text(
                'Score: ${game.score}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'retro'
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('MainMenu');
                    game.startGame(started: true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Restart?',
                    style: TextStyle(
                      fontSize: 27.0,
                      color: blackTextColor,
                      fontFamily: 'retro'
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}