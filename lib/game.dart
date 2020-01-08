import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:spacekraft/component/backdialog.dart';
import 'package:spacekraft/component/gameover.dart';
import 'package:spacekraft/component/scoredisplay.dart';
import 'package:spacekraft/httprequest/db_request.dart';
import 'package:spacekraft/sharedpreference/sharedutil.dart';
import 'package:spacekraft/sprite/bullet/ship1bullet.dart';
import 'package:spacekraft/sprite/enemyship/enemyship.dart';
import 'package:spacekraft/sprite/usership/spaceship.dart';

class Game extends BaseGame{
  SharedUtil _sharedUtil;
  BuildContext context;
  List<EnemyShip> enemy; 
  List<Ship1bullet> bullets;
  Spaceship ship;
  GameOver _gameOver;
  BackDialog _backDialog;
  ScoreDisplay _scoreDisplay;
  Rect bgRect,rectUp,rectDown,rectLeft,rectRight;
  Paint bgPaint,paintUp,paintDown,paintLeft,paintRight;
  bool btnUp=false,btnDown=false,btnLeft=false,btnRight=false;
  Size ss;
  double shipsize;
  Random rnd;
  int delayFire = 10,delaySpawnEnemy = 100;
  int life = 1,addhp = 0,addspeed = 0,score = 0,hiScore = 0,level = 1,hiLevel = 0,time = 3;
  int coins = 0,totalcoins = 0;
  String name;

  Game(BuildContext context) {
    _sharedUtil = new SharedUtil();
    initialize();
    this.context = context;
  }

  void initialize() async {
    hiScore = await _sharedUtil.getHiScore();
    hiLevel = await _sharedUtil.getHiLevel();
    totalcoins = await _sharedUtil.getCoins();
    bullets = List<Ship1bullet>();
    enemy = List<EnemyShip>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    this._scoreDisplay = ScoreDisplay(this);
    this._gameOver = GameOver(this);
    this._backDialog = BackDialog(this);
    spawnShip();
    fireBullet();
    spawnEnemy();
    paintUp = Paint();
    bgPaint = Paint();
    paintLeft = Paint();
    paintRight = Paint();
    paintDown = Paint();
  }
  void spawnShip(){
    this.ship = Spaceship(this,this.ss.width*.22, this.ss.height*.40);
  }
  void fireBullet(){
    double x = this.ship.spaceshipRect.right-this.ship.spaceshipRect.width*.50;
    double y = this.ship.spaceshipRect.top+this.ship.spaceshipRect.height*.50;
    bullets.add(Ship1bullet(this, this.ship, x, y));
  }
  void spawnEnemy(){
    double x = this.size.width;
    double y = (this.size.height*(rnd.nextInt(80)/100))+this.size.height*.08;
    if(rnd.nextInt(100)>80 && delaySpawnEnemy<=0){
      enemy.add(EnemyShip(this, x, y,this.addhp,this.addspeed));
      delaySpawnEnemy = 100;
    }
  }
  
  bool rdytoFire(){
    delayFire-=1;
    if(delayFire == 0){delayFire=10; return true;}
    return false;
  }
  void ready2spawnenemy(){
    delaySpawnEnemy-=1;
    if(time==0){
      spawnEnemy();
    }
    if(time != 0 && delaySpawnEnemy <=0){
      time -=1;delaySpawnEnemy = 100;
    }
  }

  void lvlupdate(){
    if(score >= level*200){
      addhp +=5;
      addspeed +=10;
      level +=1;
    }
    print("Score: "+score.toString());
    score>=hiScore ? hiScore = score : null;
  }

  void gameUpdate(double t){
    ready2spawnenemy();
    ship.update(t,btnUp, btnDown, btnLeft, btnRight);
    enemy.forEach((EnemyShip enemy) => enemy.update(t));
    bullets.forEach((Ship1bullet bullet) => bullet.update(t));
    rdytoFire() ? fireBullet(): null;
  }

  void reset(){
    level>hiLevel ? hiLevel = level : null;
    initialize();
    life = 1;addhp = 0;addspeed = 0;score = 0;
    level = 1;time = 3;coins = 0;
  }

  void saving() async {
    await _sharedUtil.setHiscore(hiScore.toString());
    await _sharedUtil.setLevel(hiLevel.toString());
    await _sharedUtil.setCoins(totalcoins.toString());
  }
  void quit() async {
    await _sharedUtil.setCoins(totalcoins.toString());
  }

  void render(Canvas canvas) async {
    bgRect = Rect.fromLTWH(0, 0, this.ss.width, this.ss.height);
    bgPaint.color = Color(0xff000000);
    canvas.drawRect(bgRect, bgPaint);
    // making canvas
    rectLeft = Rect.fromLTWH(this.ss.width*0.01, this.ss.height*.75, this.ss.width/12, this.ss.height/8);
    rectRight = Rect.fromLTWH(this.ss.width*0.11, this.ss.height*.75, this.ss.width/12, this.ss.height/8);
    rectUp = Rect.fromLTWH(this.ss.width*0.06, this.ss.height*.62, this.ss.width/12, this.ss.height/8);
    rectDown = Rect.fromLTWH(this.ss.width*0.06, this.ss.height*.88, this.ss.width/12, this.ss.height/8);
    
    //function
    btnUp ? paintUp.color = Color.fromRGBO(3,222, 69, 1) : paintUp.color = Color.fromRGBO(1, 23, 224, 1.0);
    btnDown ? paintDown.color = Color.fromRGBO(3,222, 69, 1) : paintDown.color = Color.fromRGBO(1, 23, 224, 1.0);
    btnLeft ? paintLeft.color = Color.fromRGBO(3,222, 69, 1) : paintLeft.color = Color.fromRGBO(1, 23, 224, 1.0);
    btnRight ? paintRight.color = Color.fromRGBO(3,222, 69, 1) : paintRight.color = Color.fromRGBO(1, 23, 224, 1.0);

    //render canvas
    enemy.forEach((EnemyShip enemy) => enemy.render(canvas));
    bullets.forEach((Ship1bullet bullet) => bullet.render(canvas));
    ship.render(canvas);
    _scoreDisplay.render(canvas);
    canvas.drawRect(rectDown, paintDown);
    canvas.drawRect(rectUp, paintUp);
    canvas.drawRect(rectRight, paintRight);
    canvas.drawRect(rectLeft, paintLeft);
    life == 0 ? _gameOver.render(canvas) : null;
    life == 2 ? _backDialog.render(canvas) : null;
  }

  void update(double t){
    lvlupdate();
    _scoreDisplay.update(t);
    bullets.removeWhere((Ship1bullet bullet) => bullet.isDead);
    enemy.removeWhere((EnemyShip enemy) => enemy.isDead);
    life == 1 ? gameUpdate(t) : null;
    _gameOver.update(t);
    _backDialog.update(t);
  }

  void resize(Size size){
    this.ss=size;
    super.resize(size);
    this.shipsize = ss.width / 12;
  }

  void onTapDown(TapDownDetails d){
    rectUp.contains(d.localPosition) ? btnUp = true : null; 
    rectDown.contains(d.localPosition) ? btnDown = true : null; 
    rectLeft.contains(d.localPosition) ? btnLeft =  true : null; 
    rectRight.contains(d.localPosition) ? btnRight = true : null;
    bullets.forEach((Ship1bullet bullet)=> bullet.onFire());
    life == 0 ? _gameOver.onTapDown(d) : null;
    life == 2 ? _backDialog.onTapDown(d) : null;
    _scoreDisplay.onTapDown(d);
    //Navigator.popAndPushNamed(context, '/');
  }

  void onTapUp(TapUpDetails d){
    rectUp.contains(d.localPosition) ? btnUp = false : null; 
    rectDown.contains(d.localPosition) ? btnDown = false : null; 
    rectLeft.contains(d.localPosition) ? btnLeft = false : null; 
    rectRight.contains(d.localPosition) ? btnRight = false : null;
    _scoreDisplay.onTapUp(d);
    life == 0 ? _gameOver.onTapUp(d,context) : null;
    life == 2 ? _backDialog.onTapUp(d,context) : null;
  }
}

