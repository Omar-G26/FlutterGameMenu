import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';


// Define a model to manage the state of the game
class isActive extends ChangeNotifier {
  bool _isGameActive = false;
  //Widget game;
 late GameWidget<SpaceInvaders> game; 
  //Widget game; 

 // bool get isGameActive => _isGameActive;

 // isActive({required this.game}); 

  void setGame(GameWidget<SpaceInvaders> SpaceGame){
    game = SpaceGame; 
    _isGameActive = true; 
  }

  void setActive(bool act){
    this._isGameActive = act; 
  }

  bool getActive(){
    return _isGameActive; 
  }

  void startGame() {
    _isGameActive = true;
    notifyListeners();
  }

  void pauseGame() {
    if(_isGameActive){
    print('hello $_isGameActive');

    game.game?.pauseEngine(); 
    notifyListeners();

    }
  }

  void resumeGame() {
    print('you may continue $_isGameActive ');
    if(_isGameActive){
    game.game?.resumeEngine(); 
    notifyListeners();
    }
  }
}
