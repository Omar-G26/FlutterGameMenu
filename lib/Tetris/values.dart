import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;


enum Direction
{
  left,
  right,
  down,
  up,
}


enum Tetromino 
{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
  
}

const Map<Tetromino, Color> TetrominoColors =
{
  Tetromino.I: Colors.blue,
  Tetromino.J: Colors.red,
  Tetromino.L: Colors.purple,
  Tetromino.O: Colors.yellow,
  Tetromino.S: Colors.deepOrange,
  Tetromino.Z: Colors.green,
  Tetromino.T: Colors.pink,

};