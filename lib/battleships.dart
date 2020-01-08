import 'package:flutter/material.dart';
import 'package:spacekraft/sharedpreference/sharedutil.dart';

class Ships extends StatefulWidget{
  BattleShips createState() => BattleShips();
}

class BattleShips extends State<Ships>{
  String selected = "";
  String name = 'Demo';
  String coins = '0'; 
  final SharedUtil pref = new SharedUtil();

  BattleShips(){
      initialize();
  }
  void initialize() async {
    String getname = await pref.getName();
    int getcoins = await pref.getCoins();
    setState(() {
      name = getname;
      coins = getcoins.toString();
    });
  }

  Widget _spaceCraft(String txt){
    return Expanded(
        child: Center(
          child: Container(
            width: 120,
            height: 120,
            child: RaisedButton(onPressed: (){setState((){selected=txt;});},
              child: Text(txt),
            ),
          )
        )
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        color: Color.fromRGBO(124, 124, 124, 0.5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text("BattleShips",style: TextStyle(
                      fontSize: 50.0,fontWeight: FontWeight.w700,
                    ),),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(name+"\nCoins: "+coins,style: TextStyle(fontSize: 20.0),),
                  ),
                )
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  selected == "SpaceShip1" ? _spaceCraft("SpaceShip1\n [Selected]") : _spaceCraft("SpaceShip1"),
                  selected == "SpaceShip2" ? _spaceCraft("SpaceShip2\n [Selected]") : _spaceCraft("SpaceShip2"),
                  selected == "SpaceShip3" ? _spaceCraft("SpaceShip3\n [Selected]") : _spaceCraft("SpaceShip3"),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  selected == "SpaceShip4" ? _spaceCraft("SpaceShip4\n [Selected]") : _spaceCraft("SpaceShip4"),
                  selected == "SpaceShip5" ? _spaceCraft("SpaceShip5\n [Selected]") : _spaceCraft("SpaceShip5"),
                  selected == "SpaceShip6" ? _spaceCraft("SpaceShip6\n [Selected]") : _spaceCraft("SpaceShip6"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
