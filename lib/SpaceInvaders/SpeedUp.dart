import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:flame/components.dart';

class SpeedUp extends SpriteAnimationComponent
    with HasGameRef<SpaceInvaders> {

  SpeedUp(bool isSpeeding) : super(    
          size: Vector2.all(40),
          anchor: Anchor.bottomCenter,
          removeOnFinish: true,
        );

   @override
   void update(double dt) {
    // TODO: implement update
    super.update(dt);

    position = game.currentPlayer.position + Vector2(0 ,  game.currentPlayer.height); 
  }     


  @override
  Future<void> onLoad() async {
    await super.onLoad();
      // sprite = await gameRef.loadSprite('EnemyHit.png');
    animation = await game.loadSpriteAnimation(
      'SpeedUp.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .1,
        textureSize: Vector2.all(7),
        loop: true,
        
      ),
    );

  }
      



}