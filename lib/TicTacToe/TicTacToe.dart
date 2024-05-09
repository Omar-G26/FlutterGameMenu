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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TicTacToe'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionPage(),
                ));
          },
          child: Icon(Icons.home),
        ),
        drawer: gameNavigationTicTacToe(context: context),
        body: Stack(children: [
          ///NavigationTicTacToe(scaffoldKey: scaffoldKey),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: 9,
                          itemBuilder: (BuildContext context, int index) {
                            int row = index ~/ 3;
                            int col = index % 3;
                            return GestureDetector(
                              onTap: () {
                                if (board[row][col] == '') {
                                  setState(() {
                                    if (player1Turn) {
                                      board[row][col] = 'X';
                                    } else {
                                      board[row][col] = 'O';
                                    }
                                    player1Turn = !player1Turn;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Center(
                                    // board[row][col] == 'X' ? TextStyle(fontSize: 50.0, color: Colors.red) : TextStyle(fontSize: 50.0, color: Colors.blue),
                                    child: board[row][col] == 'X'
                                        ? Text(board[row][col],
                                            style: TextStyle(
                                                fontSize: 70.0,
                                                color: Colors.blue))
                                        : Text(board[row][col],
                                            style: TextStyle(
                                                fontSize: 70.0,
                                                color: Colors.red))),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Reset the game
                          setState(() {
                            board = List.generate(3, (_) => List.filled(3, ''));
                            player1Turn = true;
                          });
                        },
                        child: Text('Reset'),
                      ),
                    ],
                  )))
        ])

        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     SizedBox(
        //       height: MediaQuery.of(context).size.height *
        //           0.8, // Adjust the height as needed
        //       child: Expanded(
        //         child: GridView.builder(
        //           shrinkWrap: true,
        //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 3,
        //           ),
        //           itemCount: 9,
        //           itemBuilder: (BuildContext context, int index) {
        //             int row = index ~/ 3;
        //             int col = index % 3;
        //             return GestureDetector(
        //               onTap: () {
        //                 if (board[row][col] == '') {
        //                   setState(() {
        //                     if (player1Turn) {
        //                       board[row][col] = 'X';
        //                     } else {
        //                       board[row][col] = 'O';
        //                     }
        //                     player1Turn = !player1Turn;
        //                   });
        //                 }
        //               },
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   border: Border.all(),
        //                 ),
        //                 child: Center(
        //                   child: Text(
        //                     board[row][col],
        //                     style: TextStyle(fontSize: 20.0),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         // Reset the game
        //         setState(() {
        //           board = List.generate(3, (_) => List.filled(3, ''));
        //           player1Turn = true;
        //         });
        //       },
        //       child: Text('Reset'),
        //     ),
        //   ],
        // )

        );
  }
}
