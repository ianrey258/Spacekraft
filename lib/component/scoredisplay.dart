import 'package:spacekraft/game.dart';
import 'package:flutter/material.dart';

class ScoreDisplay{
  final Game game;
  List<TextPainter> text = List<TextPainter>();
  List<TextStyle> style = List<TextStyle>();
  List<Offset> position = List<Offset>();
  Rect bg,back;
  Paint bgColor,backColor;

  ScoreDisplay(this.game){
    bg = Rect.fromLTWH(0,0,game.ss.width*.2, game.ss.height);
    bgColor = Paint();
    bgColor.color = Color.fromRGBO(162, 162, 162, 1);
    
    back = Rect.fromLTWH(0,0,game.ss.width*.10, game.ss.height*.10);
    backColor = Paint();
    backColor.color = Color.fromRGBO(255, 0, 0, 1.0);

    //scoretxt
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.22,this.game.ss.height*0));
    //scorevalue
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.2,this.game.ss.height*.05));
    //leveltxt
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.03,this.game.ss.height*.10));
    //lvlvalue
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.08,this.game.ss.height*.20));
    //hiscoretxt
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.02,this.game.ss.height*.40));
    //hiscorevalue
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.02,this.game.ss.height*.45));
    //coinstxt
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.02,this.game.ss.height*.50));
    //coinvalue
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.02,this.game.ss.height*.55));
    //backtxt
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.02,this.game.ss.height*.02));
    //ready in 3 2 1
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.4,this.game.ss.height*.4));


    style.add(TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
      fontSize: 15
    ));
    style.add(TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
      fontSize: 30
    ));
    style.add(TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
      fontSize: 45
    ));
    style.add(TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
      fontSize: 40,
      fontWeight: FontWeight.bold
    ));

  }
  void render(Canvas c){
    c.drawRect(bg, bgColor);
    c.drawRect(back, backColor);
    text[0].paint(c, position[0]);
    text[2].paint(c, position[2]);
    text[3].paint(c, position[3]);
    text[4].paint(c, position[4]);
    text[5].paint(c, position[5]);
    text[6].paint(c, position[6]);
    text[7].paint(c, position[7]);
    text[8].paint(c, position[8]);
    text[9].paint(c, position[9]);
  }
  void update(double t){
    text[0].text = TextSpan(
      text: "Score: "+this.game.score.toString(),
      style: style[0]
    );
     text[2].text = TextSpan(
      text: "LEVEL",
      style: style[1]
    );
    text[3].text = TextSpan(
      text: this.game.level.toString(),
      style: style[2]
    );
    text[4].text = TextSpan(
      text: "Your HighScore",
      style: style[0]
    );
    text[5].text = TextSpan(
      text: this.game.hiScore.toString(),
      style: style[0]
    );
    text[6].text = TextSpan(
      text: "Coins",
      style: style[0]
    );
    text[7].text = TextSpan(
      text: this.game.totalcoins.toString(),
      style: style[0]
    );
    text[8].text = TextSpan(
      text: "Quit",
      style: style[0]
    );
    this.game.time != 0 ? text[9].text = TextSpan(text: "Ready in "+this.game.time.toString(),style: style[3])
                        : text[9].text = TextSpan(text: '',style: style[3]);

    text[0].layout();
    text[2].layout();
    text[3].layout();
    text[4].layout();
    text[5].layout();
    text[6].layout();
    text[7].layout();
    text[8].layout();
    text[9].layout();
  }

  void onTapDown(TapDownDetails d){
    if(back.contains(d.localPosition)){
      backColor.color = Color.fromRGBO(255, 0, 0, 0.8);
      this.game.life = 2;
    }
  }

  void onTapUp(TapUpDetails d){
    back.contains(d.localPosition)? backColor.color = Color.fromRGBO(255, 0, 0, 1):null;
  }
}