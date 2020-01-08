import 'package:spacekraft/sprite/bullet/ship1bullet.dart';
import 'package:spacekraft/game.dart';
import 'package:flutter/material.dart';

class EnemyShip{
  final Game game;
  Rect enemyRect;
  Paint color;
  bool isDead = false;
  bool isOffScreen = false;
  int hp = 10;
  double speed=50;

  EnemyShip(this.game,double x,double y,int addhp,int addspeed){
    hp +=addhp;
    speed +=addspeed;
    enemyRect = Rect.fromLTWH(x, y, game.shipsize, game.shipsize);
    color = Paint();
    color.color = Color.fromRGBO(0, 232, 52, 1);
  }

  void render(Canvas c){
    c.drawRect(enemyRect, color);
  }

  void update(double t){
    enemyRect = enemyRect.translate(-speed*t, 0);
    !isDead ? color.color = Color.fromRGBO(0, 232, 52, 1) : null;
    game.bullets.forEach((Ship1bullet bullet){if(enemyRect.overlaps(bullet.rectBullet)){
      hp -= bullet.damage;
      game.score += bullet.damage;
      bullet.isDead = true;
      color.color = Color.fromRGBO(255, 0, 0, 1);
    }});
    enemyRect.right <0 ? isDead =true : null;
    if(hp <= 0){
      isDead =true;
      game.coins += game.level;
      game.totalcoins += game.level;
    }
  }
}