import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/GameSelectionPage.dart';
import 'package:gaminghub/gameNavigationTicTacToe.dart';

class TicTacToePage extends StatelessWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
      ),
      body: const Center(child: SizedBox(width: 100, height: 400)),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  bool player1Turn = true;
  String winner = '';
  bool botEnabled = true; // Add a flag to enable/disable the bot
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('TicTacToe'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SelectionPage(),
            ),
          );
        },
        child: Icon(Icons.home),
      ),
      drawer: gameNavigationTicTacToe(context: context),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        int row = index ~/ 3;
                        int col = index % 3;
                        return GestureDetector(
                          onTap: () {
                            if (board[row][col] == '' && player1Turn && winner.isEmpty) {
                              setState(() {
                                board[row][col] = 'X';
                                player1Turn = !player1Turn;
                                winner = _checkGameStatus();
                                if (botEnabled && !player1Turn && winner.isEmpty) {
                                  _makeBotMove();
                                }
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Text(
                                board[row][col],
                                style: TextStyle(
                                  fontSize: 70.0,
                                  color: board[row][col] == 'X' ? Colors.blue : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (winner.isNotEmpty)
                    Text(
                      winner == 'Draw' ? 'Draw!' : 'Winner: $winner',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: winner == 'X' ? Colors.blue : winner == 'O' ? Colors.red : Colors.black,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        board = List.generate(3, (_) => List.filled(3, ''));
                        player1Turn = true;
                        winner = '';
                      });
                    },
                    child: Text('Reset'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Function to check game status (win, draw)
  String _checkGameStatus() {
    // checking every row
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != '') {
        return board[i][0];
      }
    }
    // checking each column
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != '') {
        return board[0][i];
      }
    }
    // checking diagonals
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != '') {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != '') {
      return board[0][2];
    }
    // check for draw
    bool draw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          draw = false;
          break;
        }
      }
    }
    if (draw) {
      return 'Draw';
    }
    return '';
  }

  // Function to make bot move
  void _makeBotMove() {
    if (!player1Turn && winner.isEmpty) {
      Random random = Random();
      int row, col;
      do {
        row = random.nextInt(3);
        col = random.nextInt(3);
      } while (board[row][col] != '');
      setState(() {
        board[row][col] = 'O';
        player1Turn = !player1Turn;
        winner = _checkGameStatus(); // Check game status after bot's move
      });
    }
  }
}
