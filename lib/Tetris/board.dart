import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'piece.dart';
import 'values.dart';

import 'pixel.dart';

//create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
  );

class GameBoard extends StatefulWidget
{
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();

}

class _GameBoardState extends State<GameBoard>
{

//current tetris piece
Piece currentPiece = Piece(type:  Tetromino.L);

//current Score
int currentScore = 0;

// game over variable
bool gameOver = false;
@override 
void initState()
{
  super.initState();

  //start game when app starts
  startGame();
}

void startGame()
{
  currentPiece.initializePiece();


  // frame refresh rate
  Duration frameRate = const Duration(milliseconds: 165);
  gameLoop(frameRate);

}

//Game Loop
void gameLoop(Duration frameRate)
{
  Timer.periodic(
    frameRate,
    (timer)
    {
      setState(()
       {
        //clear lines
        clearLines();

        //checking the landing
        checkLanding();

        //checking every frame if the game is over or not
        if (gameOver == true)
        {
          timer.cancel();
          showGameOverDialog();
        }

        //moving the piece down
        currentPiece.movePiece(Direction.down);
      });
    },
  );
}

//Game over Dialog
void showGameOverDialog()
{
  showDialog(context: context,
   builder: (context) => AlertDialog(
    title: Text('Game Over'),
    content: Text("You scored: $currentScore"),
    actions: [
      TextButton(
        onPressed: ()
      {
        //reset the game
        resetGame();

        Navigator.pop(context);
      },
       child: Text('New Game'))
    ],
   ),
   );
}

//reset game
void resetGame() 
{
  gameBoard = List.generate(
    colLength,
    (i) => List.generate(
      rowLength,
      (j) => null,
    ),
  );

  gameOver = false;
  currentScore = 0;

  createNewPiece();

  startGame();
}

//colliders
//returning true if there is a collision
//returning false if there is no collision
bool checkCollision(Direction direction)
{
  //looping through each position of the current piece
  for (int i = 0; i < currentPiece.position.length; i++)
  {
    //calculating the row and column fo the current piece
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      //moving the row and column based on direction
      if (direction == Direction.left)
      {
        col -= 1;
      }
      else if (direction == Direction.right)
      {
        col += 1;
      }
      else if (direction == Direction.down)
      {
        row += 1;
      }
      
      //checking if the piece will collide with teh bottom or the sides of the game board
      if (row >= colLength || col < 0 || col >= rowLength)
      {
        return true;
      }

      if (row >= 0 && col >= 0)
      {
        if (gameBoard[row][col] != null)
        {
          return true;
        }
      }
  }

  return false;
}

void checkLanding()
{
  //if down has a piece in it or the floor
  if (checkCollision(Direction.down))
  {
    //marking the position as occupied on the gameboard
    for (int i = 0; i < currentPiece.position.length; i++)
    {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if (row >= 0 && col >= 0)
      {
          gameBoard[row][col] = currentPiece.type;
      }
    }
    //after marking the position, create the new piece
    createNewPiece(); 
  }
}

void createNewPiece()
{
  Random rand = Random();

  Tetromino randomType = 
    Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentPiece= Piece(type: randomType);
  currentPiece.initializePiece();

  // When creating a new piece check if ther game over function is true
  if  (isGameOver())
  {
      gameOver = true;
  }
}

void moveLeft()
{
  if ( !checkCollision(Direction.left))
  {
    setState(() 
    {
      currentPiece.movePiece(Direction.left);
    });
  }
}

//commenting out the rotate button until fix

void rotatePiece()
{
    setState(()
    {
      currentPiece.rotatePiece();
    });
}


void moveRight()
{
  if ( !checkCollision(Direction.right))
  {
    setState(() 
    {
      currentPiece.movePiece(Direction.right);
    });
  }
}

  //clear lines
  void clearLines()
  {
    for ( int row = colLength - 1; row >= 0; row--)
    {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++)
      {

        if (gameBoard[row][col] == null)
        {
          rowIsFull = false;
          break;
        }
      }

      if(rowIsFull)
      {
        for (int r = row; r > 0; r--)
        {
         gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }

  //Game over Method
  bool isGameOver() 
  {
    //check for any columns in the top row are filled
    for (int col = 0; col < rowLength; col++)
    {
      if (gameBoard[0][col] != null)
      {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //Game Grid
          /// ******************************************************
          /// Changing the game board happens below here
          /// If need be for the game menu 
          /// ******************************************************
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength),
              itemBuilder: (context, index)
              {
                //getting roow and col of each index
                int row = (index/rowLength).floor();
                int col = index % rowLength;
            
                //current piece
                if (currentPiece.position.contains(index))
                {
                  return Pixel(
                    color: Color.fromARGB(255, 252, 253, 252),
                  
                  );
                }
                //landed pieces
                else if (gameBoard[row][col] != null)
                {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(color: TetrominoColors[tetrominoType]);
                }
                //blank pixel
                else
                {
                 return Pixel(
                    color: Colors.grey[900],
                  );
                }
              }
              ),
          ),

          Text(
            'Score: $currentScore',
            style: TextStyle(color: Colors.white),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Row(
              children: [
                //left
                IconButton(onPressed: moveLeft, 
                color: Colors.white,
                icon: Icon(Icons.arrow_back)),
            
                //rotate
                /*
                ROTATE IS NOT FUNC

                IconButton(
                  onPressed : rotatePiece, 
                  color: Colors.white,
                  icon: Icon(Icons.rotate_right)
                ),
                */
            
                //right
                IconButton(
                  onPressed: moveRight, 
                  color: Colors.white,
                  icon: Icon(Icons.arrow_forward))
              ],
            ),
          )
        ],
      )
      );
  }
}