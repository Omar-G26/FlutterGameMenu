import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:gaminghub/SpaceInvaders/bullet.dart';
import 'package:gaminghub/SpaceInvaders/Explode.dart';

class Enemy extends SpriteComponent
    with HasGameRef<SpaceInvaders>, CollisionCallbacks {
  late final SpawnComponent enemyFire;
  late Timer interval;
  late Vector2 enemyDirection;
  Random random = Random();
  late double EnemyPositionX = random.nextInt(501) - 250;
  late double EnemyPositionY = random.nextDouble() * 250;
  late double EnemyFireRate = random.nextInt(4) + 1;
  late int sec;

  Enemy({required int sec, super.position,   //remove secs here 
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        ) {
          print(sec);
    interval = Timer(
      //EnemyFireRate,
      testFire(sec),
      onTick: () => shoot(),
      repeat: false,
    );
  }

  //based on time it determines the firerate from 4sec to 1sec
  double testFire(int sec) {
    double fire = 0;
    if (sec <= 10) {
      fire = 4;
    } else if (sec > 10 && sec <= 20) {
      fire = 3;
    } else if(sec > 20 && sec <= 30){
      fire = 2; 
    } else if (sec > 30){
      fire = 1; 
    }
    return fire;
  }

  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    switch (EnemyFireRate) {
      case 1:
        sprite = await gameRef.loadSprite('EnemyShip3.png');
        break;
      case 2:
        sprite = await gameRef.loadSprite('EnemyShip2.png');
        break;
      case 3:
        sprite = await gameRef.loadSprite('EnemyShip1.png');
        break;
      case 4:
        sprite = await gameRef.loadSprite('EnemyShip4.png');
        break;
    }
    // animation = await game.loadSpriteAnimation(
    //   'enemy.png',
    //   SpriteAnimationData.sequenced(
    //     amount: 4,
    //     stepTime: .2,
    //     textureSize: Vector2.all(16),
    //   ),
    // );

    enemyFire = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return enemyBullet(
          position: position +
              Vector2(
                0,
                height / 2,
              ),
        );
      },
      autoStart: false,
    );

    game.add(enemyFire);

    add(RectangleHitbox());
  }

// double randomValue = random.nextDouble() * 100 - 50;

  @override
  void update(double dt) {
    super.update(dt);
    position.y += dt * EnemyPositionY; //250

    ///Move Enemies to side of the game
    position.x += dt * EnemyPositionX; //negative left positive right

    if (position.x < 0) {
      EnemyPositionX = -EnemyPositionX;
    }
    if (position.x > game.size[0]) {
      EnemyPositionX = -EnemyPositionX;
    }

    //////////

    if (position.y > game.size.y) {
      removeFromParent(); // || position.x > game.size.x
    }

    interval.update(dt);
  }

  void shoot() {
    final bullet1 = enemyBullet(
      position: position + Vector2(0, height / 2),
    );
    game.add(bullet1);
    interval.start();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is playerBullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
      game.score += 100;
      game.scoreText.text = 'score: ${game.score}';
    }
  }
}
