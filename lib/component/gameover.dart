import 'package:spacekraft/game.dart';
import 'package:flutter/material.dart';

class GameOver{
  final Game game;
  List<TextPainter> text = List<TextPainter>();
  List<TextStyle> style = List<TextStyle>(); 
  List<Offset> position = List<Offset>();
  Paint color1,color2,color3;
  Rect bg,tryAgain,home;
  List<String> score = ['Score','New HighScore'];
  List<String> level = ['Level','New Level'];

  GameOver(this.game){
    bg = Rect.fromLTWH(this.game.ss.width*.25,this.game.ss.height*.20,this.game.ss.width*0.50,this.game.ss.height*0.50);
    color1 = Paint();
    color1.color = Color.fromRGBO(162, 162, 162, 0.5);
    
    tryAgain = Rect.fromLTWH(this.game.ss.width*.30,this.game.ss.height*.55,this.game.ss.width*0.15,this.game.ss.height*0.10);
    color2 = Paint();
    color2.color = Color.fromRGBO(0, 255, 0, 0.8);
    
    home = Rect.fromLTWH(this.game.ss.width*.55,this.game.ss.height*.55,this.game.ss.width*0.15,this.game.ss.height*0.10);
    color3 = Paint();
    color3.color = Color.fromRGBO(0, 0, 255, 0.8);
    
    //Gameover text
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.31, this.game.ss.height*.22));
    //level
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.35, this.game.ss.height*.40));
    //Score
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.rtl));
    position.add(Offset(this.game.ss.width*.35, this.game.ss.height*.35));
    //Coins
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.35, this.game.ss.height*.45));
    //tryagain
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.31, this.game.ss.height*.56));
    //home
    text.add(TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr));
    position.add(Offset(this.game.ss.width*.58, this.game.ss.height*.57));
    
    style.add(TextStyle(fontSize: 10,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 15,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 15,color:  Color.fromRGBO(255, 255, 255, 1),fontWeight: FontWeight.bold));
    style.add(TextStyle(fontSize: 20,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 25,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 35,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 40,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 45,color:  Color.fromRGBO(255, 255, 255, 1)));
  }

  void render(Canvas c){
    c.drawRect(bg, color1);
    c.drawRect(tryAgain, color2);
    c.drawRect(home, color3);
    text[0].paint(c, position[0]);text[3].paint(c, position[3]);
    text[1].paint(c, position[1]);text[4].paint(c, position[4]);
    text[2].paint(c, position[2]);text[5].paint(c, position[5]);
  }

  void update(double t){
    text[0].text = TextSpan(text: 'Game Over!',style: style[7]);
    this.game.level>this.game.hiLevel ? text[1].text = TextSpan(text: level[1]+'   '+this.game.level.toString(),style: style[2]) 
                             : text[1].text = TextSpan(text: level[0]+'   '+this.game.level.toString(),style: style[1]);
    this.game.score==this.game.hiScore ? text[2].text = TextSpan(text: score[1]+'   '+this.game.score.toString(),style: style[2])
                             :text[2].text = TextSpan(text: score[0]+'   '+this.game.score.toString(),style: style[1]);
    text[3].text = TextSpan(text: 'Coin Earned   '+this.game.coins.toString(),style: style[1]);
    text[4].text = TextSpan(text: 'Try Again',style: style[3]);
    text[5].text = TextSpan(text: 'Home',style: style[3]);
    text[0].layout();text[3].layout();
    text[1].layout();text[4].layout();
    text[2].layout();text[5].layout();
  }
  void onTapDown(TapDownDetails d){
    if(tryAgain.contains(d.localPosition)){
      color2.color = Color.fromRGBO(50, 255, 50, 0.8);
    }
    if(home.contains(d.localPosition)){
      color3.color = Color.fromRGBO(50, 50, 255, 0.8);
    }
  }
  void onTapUp(TapUpDetails d,BuildContext context){
    if(tryAgain.contains(d.localPosition)){
      color2.color = Color.fromRGBO(0, 255, 0, 0.8);
      this.game.saving();
      this.game.reset();
    }
    if(home.contains(d.localPosition)){
      color3.color = Color.fromRGBO(0, 0, 255, 0.8);
      this.game.saving();
      Navigator.popAndPushNamed(context,'/');
    }
  }
}