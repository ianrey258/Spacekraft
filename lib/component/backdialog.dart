import 'package:spacekraft/game.dart';
import 'package:flutter/material.dart';

class BackDialog{
  final Game game;
  Rect bg,yes,no;
  Paint bgColor,yesColor,noColor;
  List<TextPainter> text = List<TextPainter>();
  List<TextStyle> style = List<TextStyle>();
  List<Offset> position = List<Offset>();

  BackDialog(this.game){
    bg = Rect.fromLTWH(game.ss.width*.35,game.ss.height*.20,game.ss.width*.30,game.ss.height*.35);
    bgColor = Paint();
    bgColor.color = Color.fromRGBO(134, 134, 134, 0.6);

    yes = Rect.fromLTWH(game.ss.width*.38,game.ss.height*.40,game.ss.width*.10,game.ss.height*.10);
    yesColor = Paint();
    yesColor.color = Color.fromRGBO(0, 200, 0, 0.9);

    no = Rect.fromLTWH(game.ss.width*.53,game.ss.height*.40,game.ss.width*.10,game.ss.height*.10);
    noColor = Paint();
    noColor.color = Color.fromRGBO(200, 0, 0, 0.9);

    style.add(TextStyle(fontSize: 10,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 15,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 20,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 25,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 35,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 40,color:  Color.fromRGBO(255, 255, 255, 1)));
    style.add(TextStyle(fontSize: 45,color:  Color.fromRGBO(255, 255, 255, 1)));

    //Do you want to Quit?
    text.add(TextPainter(textAlign: TextAlign.center,
                         textDirection: TextDirection.ltr,
                         text: TextSpan(text: 'Are you Sure?',style: style[3])
                        ));
    position.add(Offset(game.ss.width*.38,game.ss.height*.25));
    //Yes
    text.add(TextPainter(textAlign: TextAlign.center,
                         textDirection: TextDirection.ltr,
                         text: TextSpan(text: 'Yes',style: style[2])
                        ));
    position.add(Offset(game.ss.width*.40,game.ss.height*.42));
    //No
    text.add(TextPainter(textAlign: TextAlign.center,
                         textDirection: TextDirection.ltr,
                         text: TextSpan(text: 'No',style: style[2])
                        ));
    position.add(Offset(game.ss.width*.56,game.ss.height*.42));
  }

  void render(Canvas canvas){
    canvas.drawRect(bg, bgColor);
    canvas.drawRect(yes, yesColor);
    canvas.drawRect(no, noColor);
    text[0].paint(canvas, position[0]);
    text[1].paint(canvas, position[1]);
    text[2].paint(canvas, position[2]);
  }

  void update(double t){ 
    text[0].layout();
    text[1].layout();
    text[2].layout();
  }

  void onTapDown(TapDownDetails d){
    if(yes.contains(d.localPosition)){
      yesColor.color = Color.fromRGBO(0, 200, 0, 0.7);
    }
    if(no.contains(d.localPosition)){
      noColor.color = Color.fromRGBO(200, 0, 0, 0.7);
    }
  }

  void onTapUp(TapUpDetails d,BuildContext context){
    if(yes.contains(d.localPosition)){
      yesColor.color = Color.fromRGBO(0, 200, 0, 0.9);
      this.game.quit();
      Navigator.popAndPushNamed(context,'/');
    }
    if(no.contains(d.localPosition)){
      noColor.color = Color.fromRGBO(200, 0, 0, 0.9);
      this.game.life = 1;
    }
  }
}