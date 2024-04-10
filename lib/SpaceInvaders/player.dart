import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gaminghub/GameOver.dart';
import 'package:gaminghub/SpaceInvaders/SpaceInvaders.dart';
import 'package:gaminghub/SpaceInvaders/SpeedUp.dart';
import 'package:gaminghub/SpaceInvaders/bullet.dart';
import 'package:gaminghub/SpaceInvaders/enemy.dart';
import 'package:gaminghub/SpaceInvaders/Explode.dart';



//SpriteAnimationComponent
//SpriteComponent
class Player extends SpriteComponent
    with KeyboardHandler, HasGameRef<SpaceInvaders> ,CollisionCallbacks{
  late final SpawnComponent fire;
  Vector2 velocity = Vector2.zero();
  late double speed = 800;
  Vector2 direction = Vector2(0, 0);
  bool isSpeeding = false; 

  
  Player() : super(
          size: Vector2(70, 70),
          anchor: Anchor.center,
        ); 

  @override
  Future<void> onLoad() async {
    await super.onLoad();

   sprite = await gameRef.loadSprite('PlayerShip2.png');
 
    position = gameRef.size / 2;
    add(RectangleHitbox());
 
  }


  @override
  void update(double dt) {
    super.update(dt);
    velocity = direction.normalized() * speed;
    position += velocity * dt;
     // shootCooldown.update(dt);
  } 


  void Shoot() {
      final bullet1 = playerBullet(
        position: position - Vector2(0, height),
      );
      game.add(bullet1);
    //   cooldown = true; 

    //   game.add(TimerComponent(
    //     period: 2,
    //     repeat: true,
    //     onTick: () => { 
    //     print('coolwwdown changed'),
    //     cooldown = false,
    // }));   
    
  }

//Player movements
  Future<void> moveRight() async {
    sprite = await gameRef.loadSprite('PlayerShip2Right.png');
    direction.x = 1;
  }

  Future<void> moveLeft() async {
    sprite = await gameRef.loadSprite('PlayerShip2Left.png');
    direction.x = -1;
  }

  void moveUp() {
  //  final speed= SpeedUp(isSpeeding); 
  //  game.add(speed); 
    direction.y = -1;
  }

  void moveDown() {
    direction.y = 1;
  }

  void Stop() {
    direction.setValues(0, 0);
  }

  Future<void> StopX() async {
    sprite = await gameRef.loadSprite('PlayerShip2.png');
    direction.x = 0;
  }

  void StopY() {
    //  final speedUp = game.components.firstWhereType<SpeedUp>();
    //     if (speedUp != null) {
    //   game.remove(speedUp); // Remove the animation component
    //    }
    //   isSpeeding = false;
    direction.y = 0;
  }


   @override
  void onCollisionStart(Set<Vector2> intersectionPoints,PositionComponent other ) {
        super.onCollisionStart(intersectionPoints, other);

        print('other is ${other} check other is Enemy ${other is Enemy}');

   if (other is enemyBullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
      print('This is the position of blown up ship $position');
    //  game.overlays.add(GameOver());
    } else if(other is Enemy){
      removeFromParent();
      game.add(Explosion(position: position));
    }
  }

}
