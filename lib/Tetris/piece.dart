import 'dart:ui';
import 'board.dart';
import 'values.dart';


class Piece 
{

  Tetromino type;

  Piece({required this.type});

  //list of integers for the piece
  List<int> position = [];

  Color get color 
  {
    return TetrominoColors[type] ??
      const Color(0xFFFFFFFF);
  }

  //generating the ints
  void initializePiece()
  {
    switch (type)
    {
      case Tetromino.L:
      position = [
        -26,
        -16,
        -6,
        -5,
      ];
      break;
      case Tetromino.J:
      position = [
        -25,
        -15,
        -5,
        -6,
      ];
      break;
      case Tetromino.I:
      position = [
        -4,
        -5,
        -6,
        -7,
      ];
      break;
      case Tetromino.O:
      position = [
        -15,
        -16,
        -5,
        -6,
      ];
      break;
      case Tetromino.S:
      position = [
        -15,
        -14,
        -6,
        -5,
      ];
      break;
      case Tetromino.T:
      position = [
        -17,
        -16,
        -6,
        -5,
      ];
      break;
      case Tetromino.Z:
      position = [
        -26,
        -16,
        -6,
        -15,
      ];
      break;
      default:
    }
  }


 //move the piece
 void movePiece(Direction direction)
 {
  switch (direction)
  {
    case Direction.down:
    for (int i = 0; i < position.length; i++)
    {
      position[i] += rowLength;
    }
    break;
    

    case Direction.left:
    for (int i = 0; i < position.length; i++)
    {
      position[i] -= 1;
    }
    break;
   

    case Direction.right:
    for (int i = 0; i < position.length; i++)
    {
      position[i] += 1;
    }
    break;
    default:
  }
 }

int rotateState = 1;

 //rotate Button
 void rotatePiece()
 {
  //new position
  List<int> newPosition = [];

  //rotate the piece based on its type
  switch (type)
  {

    //Shape L
    case Tetromino.L:
    switch(rotateState)
    {
      case 0:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1] + rowLength + 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
      
      case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1]+1,
        position[1] + rowLength - 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 2:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1]-rowLength,
        position[1] - rowLength + 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 3:
      newPosition = [
        position[1] -rowLength + 1,
        position[1],
        position[1]+1,
        position[1] - 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
    }

    // Shape J
    case Tetromino.J:
    switch(rotateState)
    {
      case 0:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1] + rowLength + 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1]+1,
        position[1] + rowLength - 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 2:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1]-rowLength,
        position[1] - rowLength + 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 3:
      newPosition = [
        position[1] -rowLength + 1,
        position[1],
        position[1]+1,
        position[1] - 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
    }

    // Shape I
    case Tetromino.I:
    switch(rotateState)
    {
      case 0:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1] + rowLength + 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1]+1,
        position[1] + rowLength - 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 2:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1]-rowLength,
        position[1] - rowLength + 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 3:
      newPosition = [
        position[1] -rowLength + 1,
        position[1],
        position[1]+1,
        position[1] - 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
    }

    case Tetromino.S:
    switch(rotateState)
    {
      case 0:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1] + rowLength + 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1]+1,
        position[1] + rowLength - 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 2:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1]-rowLength,
        position[1] - rowLength + 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 3:
      newPosition = [
        position[1] -rowLength + 1,
        position[1],
        position[1]+1,
        position[1] - 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
    }

    case Tetromino.Z:
    switch(rotateState)
    {
      case 0:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1] + rowLength + 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1]+1,
        position[1] + rowLength - 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 2:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1]-rowLength,
        position[1] - rowLength + 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 3:
      newPosition = [
        position[1] -rowLength + 1,
        position[1],
        position[1]+1,
        position[1] - 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
    }

    case Tetromino.T:
    switch(rotateState)
    {
      case 0:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1] + rowLength + 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1]+1,
        position[1] + rowLength - 1,
      ];

      if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 2:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1]-rowLength,
        position[1] - rowLength + 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;

      case 3:
      newPosition = [
        position[1] -rowLength + 1,
        position[1],
        position[1]+1,
        position[1] - 1,
      ];

       if (piecePositionIsValid(newPosition))
      {
        position = newPosition;

        rotateState = (rotateState + 1) % 4;
      }
      break;
    }

    break;
    default:
  }
 }

  bool positionIsValid(int position)
  {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null)
    {
      return false;
    }
    else
    {
      return true;
    }
  }


  bool piecePositionIsValid(List<int> piecePosition)
  {
    bool firstColOccupied = false;
    bool lastColOcupied = false;

    for (int pos in piecePosition)
    {
      if (!positionIsValid(pos))
      {
        return false;
      }

      int col = pos % rowLength;

      if (col == 0) 
      {
        firstColOccupied = true;
      }
      if (col == rowLength -1)
      {
        lastColOcupied = true;
      }
    }

    return !(firstColOccupied && lastColOcupied);
  }
}