import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:gaminghub/Pages/GameHomePage.dart';
import 'package:gaminghub/Pages/SpaceGameMenu.dart';
import 'package:gaminghub/ScoreHandler/scoreData.dart';

import 'package:gaminghub/TicTacToe/TicTacToe.dart';
import 'package:gaminghub/Tetris/board.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);
  @override
  GameSelectionPage createState() => GameSelectionPage();
}

class GameSelectionPage extends State<SelectionPage> {
  // GameSelectionPage({Key? key}) : super(key: key);
  late FocusableControlState e;
  String hoveredButton = '';
  late Widget image;

  final Scores scoreData = Scores();
  late List<Widget> tempScoreView = [];
  late int tempHighScore = 0;
  late bool hasScore = false;

  void handleHover(String button) {
    setState(() {
      hoveredButton = button;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scoreData.load();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Selection'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GameHomePage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              FocusableActionDetector(
                onShowHoverHighlight: (_) async {
                  handleHover('assets/images/GameSpaceScreen.png');
                  tempScoreView.clear();
                  hasScore = true;
                  tempHighScore = await scoreData.getSpaceShooterHighScore();
                  for (var score in await scoreData.getSpaceShooterScores()) {
                    tempScoreView.add(ListTile(
                        title: Text(score.toString(),
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'retro'))));
                  }
                },
                child: GameSelectButton(
                  label: 'Space Shooter Game',
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpaceInvadersPage(),
                    ),
                  ),
                ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds),
              ),
              const SizedBox(height: 16),
              FocusableActionDetector(
                  onShowHoverHighlight: (_) {
                    handleHover('assets/images/TicTacToe.png');
                    hasScore = false;
                  },
                  child: GameSelectButton(
                    label: 'Tic Tac Toe',
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicTacToeGame(),
                      ),
                    ),
                  ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds)),
              const SizedBox(height: 16),
              FocusableActionDetector(
                  onShowHoverHighlight: (_) async {
                    handleHover('assets/images/tetris.png');
                    tempScoreView.clear();
                    hasScore = true;
                    tempHighScore = await scoreData.getTetrisHighScore();
                    for (var score in await scoreData.getTetrisScores()) {
                      tempScoreView.add(ListTile(
                          title: Text(score.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'retro'))));
                    }
                  },
                  child: GameSelectButton(
                    label: 'Tetris',
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameBoard(),
                      ),
                    ),
                  ).animate().fadeIn(delay: 0.3.seconds, duration: .2.seconds)),
            ]),
            SizedBox(width: 20),
            SizedBox(
              width: 500,
              height: 500,
              child: hoveredButton == ''
                  ? Container()
                  : Image(image: AssetImage(hoveredButton), fit: BoxFit.cover)
                      .animate()
                      .fadeIn(delay: 0.1.seconds, duration: .2.seconds),
            ),
            // Column(children: [],)
            SizedBox(width: 50),
            SizedBox(
                width: 200,
                height: 500,
                child: hasScore
                    ? ScoreListView(
                        HighScore: tempHighScore, ScoreList: tempScoreView)
                    : Container())
          ],
        ),
      ),
    );
  }
}

class GameSelectButton extends StatelessWidget {
  const GameSelectButton({
    required this.onPressed,
    required this.label,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FocusableControlBuilder(
      onPressed: onPressed,
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 250,
            height: 60,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: (!(state.isHovered || state.isFocused)) ? 1 : 0,
                  duration: .3.seconds,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                    ),
                  ),
                ),

                if (state.isHovered || state.isFocused) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D1FF).withOpacity(.1),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                  ),
                ],
                Center(
                  child: Text(label.toUpperCase(),
                      style: TextStyle(fontFamily: 'retro')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScoreListView extends StatelessWidget {
  const ScoreListView({
    required this.HighScore,
    required this.ScoreList,
  });
  final List<Widget> ScoreList;
  final int HighScore;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          "HIGHSCORE ",
          style: TextStyle(fontSize: 28, fontFamily: 'retro'),
        ),
        ListTile(
            title: Text('$HighScore',
                style: const TextStyle(fontSize: 18, fontFamily: 'retro'))),
        SizedBox(
          height: 20,
        ),
        const Text(
          "SCORES",
          style: TextStyle(fontSize: 28, fontFamily: 'retro'),
        ),
        ...ScoreList
      ],
    );
  }
}
