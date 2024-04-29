import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';


class playerBullet extends SpriteComponent with HasGameRef<SpaceInvaders> {
  playerBullet({super.position})
      : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('Projectile1.png');

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );

    
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y -= dt * 500;
    //print('position x ${position.x} andwidth $width');
    if (position.y < -height || position.x < width || position.y < 0 || position.x < -3) {
      removeFromParent();
    }
  }
}



class enemyBullet extends SpriteComponent with HasGameRef<SpaceInvaders> {
  late Vector2 playerPosition = game.currentPlayer.position; 
  late Vector2 velocity; 


  enemyBullet({super.position})
      : super(
          size: Vector2(25, 25),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('SpaceShooterBlueorb.png');


    final direction = playerPosition - position;
    direction.normalize();  
    velocity = direction * 500; 
    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

   // position.y -= dt * 500;
    position += velocity * dt;

    if (position.y < -height || position.x < width || position.y < 0 || position.x <= 0) {
      removeFromParent();
    }
  }
}
