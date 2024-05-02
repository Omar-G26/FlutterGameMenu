// import 'package:sleeptrackerapp/Utility/DatabaseStore.dart';

import 'package:flutter/services.dart';

class SpaceShooterStorageManager
{

  SpaceShooterStorageManager({required this.highscore, required this.scores});
  
  String highscore; 
  List<String> scores = [];

  Map<String, dynamic> toJson() => {
      'HIGHSCORE' : highscore, 
      'SCORES' : scores
  };

  void FromJson(Map<String, dynamic> json) {
    highscore = json['HIGHSCORE'];
    scores = List<String>.from(json['SCORES']);  
  }

  factory SpaceShooterStorageManager.fromJson(Map<String, dynamic> json) => SpaceShooterStorageManager(
    highscore: json['HIGHSCORE'],
    scores: json['SCORES']
  );
}

