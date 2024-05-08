
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';

class MainMenu extends StatelessWidget {
  final SpaceInvaders game;
  //final background game;
  //final SpaceGame game;


  const MainMenu({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);

    return Material(
      color: Colors.transparent,
      child:
          // Row(children: [
          Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 250,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Space Shooter',
                style: TextStyle(
                    color: Colors.white, fontSize: 50, fontFamily: 'retro'),
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
                    'Play',
                    style: TextStyle(
                        fontSize: 40.0,
                        color: blackTextColor,
                        fontFamily: 'retro'),
                  ),
                ),
              ),
            ],
          ),
        ),

        const Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
       //  Container(height: 300, width: 300, child: Image.asset('assets/images/PlayerShip2.png', scale: 0.12)),
        //  Image.asset(
        //         'assets/images/PlayerShip2.png',
        //         width: 500,
        //         height: 100,
        //       ),
        Text(
          ' Move with W,A,S,D \n or Arrow keys to move.\n Use SpaceBar to fire bullets',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontFamily: 'retro'),
        )])
      ])),
    );
  }
}


