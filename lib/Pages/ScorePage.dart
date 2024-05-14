import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gaminghub/ScoreHandler/scoreData.dart';

class ScoresPage extends StatelessWidget {
  const ScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scores = Provider.of<Scores>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: scores.load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<int>(
                    future: scores.getSpaceShooterHighScore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'Space Shooter High Score: ${snapshot.data}',
                          style: const TextStyle(fontSize: 20),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<int>(
                    future: scores.getTetrisHighScore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'Tetris High Score: ${snapshot.data}',
                          style: const TextStyle(fontSize: 20),
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
