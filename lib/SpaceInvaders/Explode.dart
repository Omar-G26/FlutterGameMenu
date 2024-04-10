import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:flame/components.dart';


class Explosion extends SpriteAnimationComponent
    with HasGameRef<SpaceInvaders> {
  Explosion({
    super.position,
  }) : super(    
          size: Vector2.all(100),
          anchor: Anchor.center,
          removeOnFinish: true,
        );


  @override
  Future<void> onLoad() async {
    await super.onLoad();
      // sprite = await gameRef.loadSprite('EnemyHit.png');
    animation = await game.loadSpriteAnimation(
      'BlowUp.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: .1,
        textureSize: Vector2.all(8),
        loop: false,
      ),
    );
  }
}