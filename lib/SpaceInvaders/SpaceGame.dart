import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';




class SpaceGame extends FlameGame {
late bool startGame = false; 

@override
FutureOr<void> onLoad() async{
    // TODO: implement onLoad
     final background = await loadParallaxComponent(
      [
        ParallaxImageData('Background1.png'),
        ParallaxImageData('Stars.png')
      ],
      baseVelocity: Vector2(0, -5), //Set the y coordinate to move -5 per second
      repeat: ImageRepeat.repeat, //
      velocityMultiplierDelta:
          Vector2(0, 5), 
    );

    add(background);

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if(startGame){
     SpaceInvaders(); 
    }


  }




}