
class Scores {


 int SpaceInvadersHighScore = 5000; 
 List<int> SpaceInvadersRecentScores = [1000,2000,500,230];  //dummmy data

 int TetrisHighScore = 8000; 
 List<int> TetrisRecentScores = [6000,1000,3000,502];



  void SpaceInvadersScoreManager(int newScore) {

    if(newScore > SpaceInvadersHighScore){
      SpaceInvadersHighScore = newScore; 
    }

    SpaceInvadersRecentScores.add(newScore);
    print(' high score $SpaceInvadersHighScore'); 
    print(SpaceInvadersRecentScores);  
  }

}