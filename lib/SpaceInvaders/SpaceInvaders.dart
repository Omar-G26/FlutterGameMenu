import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:gaminghub/SpaceInvaders/bullet.dart';
import 'package:gaminghub/SpaceInvaders/player.dart';
import 'package:gaminghub/SpaceInvaders/enemy.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';
import 'package:gaminghub/ScoreHandler/scoreData.dart';

import 'package:flutter/services.dart';

//PanDetector
//KeyboardEvents
class SpaceInvaders extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  late Player currentPlayer;
  late SpawnComponent enemySpawn;
  bool gameOver = false;
  late bool initializeGame;
  late int score = 0;
  late int HighScore = 0;
  late TextComponent scoreText;
  final Scores scoreData = Scores();

  late Future<Sprite> pauseOverlayIdentifier = loadSprite('pause.png');

  late int elapsedSecs = 0;
  late Timer interval;

  SpaceInvaders() {
    interval = Timer(
      1,
      onTick: () => {elapsedSecs += 1, 
     // print(elapsedSecs)
      },
      repeat: true,
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print(size.y);
    final background = await loadParallaxComponent(
      [ParallaxImageData('Background1.png'), ParallaxImageData('Stars.png')],
      baseVelocity: Vector2(0, -5), //Set the y coordinate to move -5 per second
      repeat: ImageRepeat.repeat, //
      velocityMultiplierDelta: Vector2(0, 5),
      // fill: LayerFill.none
    );

    // add(
    //   SpawnComponent(
    //     factory: (index) {
    //       return Enemy();
    //     },
    //     period: 1,
    //     area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
    //   ),
    // );

    scoreText = TextComponent(
      text: 'score: $score',
      textRenderer: TextPaint(
        style: const TextStyle(
            fontSize: 32, color: Colors.white, fontFamily: 'retro'),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x - 130, 20),
    );

    enemySpawn = SpawnComponent(
      factory: (index) {
        return Enemy(sec: elapsedSecs);
      },
      period: 1,
      area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
    );

    add(background);
    currentPlayer = Player();
    startGame(started: false);
    //add(currentPlayer);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (currentPlayer.x > size[0]) {
      currentPlayer.x = size[0];
    }
    if (currentPlayer.x < 0) {
      currentPlayer.x = 0;
    }

    if (currentPlayer.y > size.y) {
      currentPlayer.y = size.y;
    }

    if (currentPlayer.y < 0) {
      //top of the screen
      currentPlayer.y = 0;
    }

    if (initializeGame == true) {
      interval.update(dt);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      //  print('key down ${event.logicalKey}');
      var left = event.logicalKey == LogicalKeyboardKey.keyA ||
          event.logicalKey == LogicalKeyboardKey.arrowLeft;
      var right = event.logicalKey == LogicalKeyboardKey.keyD ||
          event.logicalKey == LogicalKeyboardKey.arrowRight;
      var up = event.logicalKey == LogicalKeyboardKey.keyW ||
          event.logicalKey == LogicalKeyboardKey.arrowUp;
      var down = event.logicalKey == LogicalKeyboardKey.keyS ||
          event.logicalKey == LogicalKeyboardKey.arrowDown;

      if (left) {
        currentPlayer.moveLeft();
        return KeyEventResult.handled;
      } else if (right) {
        currentPlayer.moveRight();
        return KeyEventResult.handled;
      } else if (up) {
        currentPlayer.moveUp();
        return KeyEventResult.handled;
      } else if (down) {
        currentPlayer.moveDown();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        //add timer component here
        currentPlayer.Shoot();
        return KeyEventResult.handled;
      }
    } else if (event is KeyUpEvent) {
      //    print('key up ${event.logicalKey}');

      var left = event.logicalKey == LogicalKeyboardKey.keyA ||
          event.logicalKey == LogicalKeyboardKey.arrowLeft;
      var right = event.logicalKey == LogicalKeyboardKey.keyD ||
          event.logicalKey == LogicalKeyboardKey.arrowRight;
      var up = event.logicalKey == LogicalKeyboardKey.keyW ||
          event.logicalKey == LogicalKeyboardKey.arrowUp;
      var down = event.logicalKey == LogicalKeyboardKey.keyS ||
          event.logicalKey == LogicalKeyboardKey.arrowDown;

      if (left || right) {
        currentPlayer.StopX();
      } else if (up || down) {
        currentPlayer.StopY();
      } else if (left || right && up || down) {
        currentPlayer.Stop();
      }
    }
    return KeyEventResult.ignored;
  }

  void endGame() {
    scoreData.UpdateSpaceShooterData(score);
    gameOver = true;
    initializeGame = false;
    elapsedSecs = 0;
    enemySpawn.removeFromParent();
    scoreText.removeFromParent();
    //score = 0;
    // print('sthis is the score b4 $score');
    // scoreText.text = 'score: ${score}';
    // print('this is the score $score');
  }

  void startGame({required bool started}) {
    initializeGame = started;
    if (started == true) {
      if (overlays.isActive('GameOver')) {
        overlays.remove('GameOver');
      }

      if (hasChildren && gameOver == true) {
        List<Enemy> currentEnemiesOnScreen =
            children.whereType<Enemy>().toList();
        List<enemyBullet> currentBulletOnScreen =
            children.whereType<enemyBullet>().toList();
        removeAll(currentBulletOnScreen);
        removeAll(currentEnemiesOnScreen);

        gameOver = false;
      }
      score = 0; 
      scoreText.text = 'score: ${score}';


      add(scoreText);
      currentPlayer.position.setFrom(size / 2);
      add(currentPlayer);

      // add(
      //   SpawnComponent(
      //     factory: (index) {
      //       return Enemy();
      //     },
      //     period: 1,
      //     area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      //   ),
      // );

      add(enemySpawn);

      //overlays.add('PAUSEEEEEEE');
    }
  }

  @override
  void pauseEngine() {
    // TODO: implement pauseEngine
    super.pauseEngine();
    print(overlays.activeOverlays);
  }

  @override
  void resumeEngine() {
    // TODO: implement resumeEngine
    super.resumeEngine();
  }
}
