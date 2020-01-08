import 'package:spacekraft/sprite/enemyship/enemyship.dart';
import 'package:spacekraft/game.dart';
import 'package:flutter/material.dart';
class Spaceship{
  final Game game;
  Rect spaceshipRect;
  Paint color;
  bool isDead = false;
  bool isOffScreen = false;
  double speed;

  Spaceship(this.game,double x,double y){
    spaceshipRect = Rect.fromLTWH(x, y, game.shipsize, game.shipsize);
    color = Paint();
    color.color = Color.fromRGBO(162, 162, 162, 1.0);
    speed = 10.0*game.shipsize;
  }
  void render(Canvas c){
    c.drawRect(spaceshipRect, color);
  }
  void update(double t,bool up,bool down,bool left,bool right){
    game.enemy.forEach((EnemyShip enemy){
      if(spaceshipRect.overlaps(enemy.enemyRect)){
        game.life=0;
        isDead = true;
      }
    });
    up && spaceshipRect.top > game.ss.height*.08 ? spaceshipRect = spaceshipRect.translate(0, -speed*t) : null;
    down && spaceshipRect.bottom < game.ss.height ?  spaceshipRect = spaceshipRect.translate(0, speed*t) : null;
    left && spaceshipRect.left > game.ss.width*.22 ?  spaceshipRect = spaceshipRect.translate(-speed*t, 0) : null;
    right && spaceshipRect.right < game.ss.width ?  spaceshipRect = spaceshipRect.translate(speed*t, 0) : null;
  }


}