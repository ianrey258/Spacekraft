import 'package:spacekraft/sprite/usership/spaceship.dart';
import 'package:spacekraft/game.dart';
import 'package:flutter/material.dart';
class Ship1bullet{
  final Game game;
  final Spaceship ship;
  Rect rectBullet;
  Paint color;
  bool isDead = false;
  bool isOffScreen = false;
  bool fire = true;
  int damage = 2;
  Ship1bullet(this.game,this.ship,double x,double y){
    rectBullet = Rect.fromLTWH(x, y, ship.spaceshipRect.width/10, ship.spaceshipRect.height/10);
    color = Paint();
    color.color = Color.fromRGBO(226, 5, 11, 1.0);
  }

  void render(Canvas c){
    c.drawRect(rectBullet, color);
  }
  void update(double t){
    if(fire){
      rectBullet = rectBullet.translate(10, 0);
      if(rectBullet.left > game.ss.width){
        isDead = true;
        isOffScreen = true;
      }
    }
  }
  void onFire(){
    this.fire = true;
  }

}