import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class Scores extends ChangeNotifier {
  late int spaceHighscore = 0;
  late List<dynamic> spaceScores = []; //7 max

  late int tetrisHighScore = 0;
  late List<dynamic> tetrisScores = [];

  void SpaceInvadersScoreManager(int newScore) async {
    await load();
    if (newScore > spaceHighscore) {
      spaceHighscore = newScore;
    }
    if(spaceScores.length >= 7) spaceScores.removeLast(); 
    spaceScores.add(newScore);
    await update(); 
  }

  Future<void> load() async {
    final dir = await getApplicationDocumentsDirectory()
        .then((Directory directory) => '${directory.path}\\scores.json');
    File file = File(dir);

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
      // print('the jsonString in _load $userMap');
      spaceHighscore = userMap['SpaceGame'][0]['HIGHSCORE'];
      spaceScores = userMap['SpaceGame'][0]['SCORES'];
      tetrisHighScore = userMap['Tetris'][0]['HIGHSCORE'];
      tetrisScores = userMap['Tetris'][0]['SCORES'];

      spaceScores.sort((a, b) => b.compareTo(a));
      tetrisScores.sort((a, b) => b.compareTo(a));

    } else {
      await File(dir).create();
      await update();
    }
  }

  Future<void> update() async {
    final dir = await getApplicationDocumentsDirectory()
        .then((Directory directory) => '${directory.path}\\scores.json');
        print(dir);

    Map<String, dynamic> Data = {
      "SpaceGame": [
        {
          "HIGHSCORE": spaceHighscore,
          "SCORES": spaceScores,
        }
      ],
      "Tetris": [
        {
          "HIGHSCORE": tetrisHighScore,
          "SCORES": tetrisScores,
        }
      ]
    };

    String encode = jsonEncode(Data);

    File(dir).writeAsString(encode);
    // .then((_) {
    //   print('Data written to scores.json');
    // }).catchError((error) {
    //   print('Error writing data: $error');
    // });

    await load(); 
    notifyListeners();
  }

  Future<void> updateSpaceShooter(int newScore) async {
    if (newScore > spaceHighscore) {
      spaceHighscore = newScore;
    }

    spaceScores.add(newScore);
    // print(' high score $SpaceInvadersHighScore'); //write to JSON?
  }

  Future<int> getSpaceShooterHighScore() async {
    if (spaceHighscore == 0) await load();
    return spaceHighscore;
  }

  Future<List<dynamic>> getSpaceShooterScores() async {
    if (spaceScores.isEmpty) await load();
    // await _load();
    return spaceScores;
  }

  Future<int> getTetrisHighScore() async {
    if (tetrisHighScore == 0) await load();
    // await _load();
    return tetrisHighScore;
  }

  Future<List<dynamic>> getTetrisScores() async {
    if (tetrisScores.isEmpty) await load();
    //  await _load();
    return tetrisScores;
  }
}
