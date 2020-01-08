import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacekraft/sqlite/userdata.dart';
import 'package:spacekraft/sqlite/usership.dart';

abstract class SharedInit{
  Future<bool> setName(String name);
  Future<bool> setData(String data);
  Future<bool> setLevel(String hiLevel);
  Future<bool> setHiscore(String hiScore); 
  Future<bool> setCoins(String coins);
  Future<String> getName();
  Future<int> getId();
  Future<int> getCoins();
  Future<int> getHiLevel();
  Future<int> getHiScore();
  Future<String> getPass();
  Future<bool> hasCacheData();
}

class SharedUtil implements SharedInit{

  Future<bool> setName(String name) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Name', name);
    return true;
  }

  Future<bool> setLevel(String hiLevel) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('hiLevel', hiLevel);
    return true;
  }

  Future<bool> setHiscore(String hiScore) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('hiScore', hiScore);
    return true;
  }

  Future<bool> setCoins(String coins) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('coins', coins);
    return true;
  }

  Future<bool> setData(String data) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    List parsejson = json.decode(data);
    pref.setString('id', parsejson[0]['id']);
    pref.setString('pass', parsejson[0]['password']);
    pref.setString('hiLevel', parsejson[0]['hiLevel']);
    pref.setString('hiScore', parsejson[0]['hiScore']);
    pref.setString('coins', parsejson[0]['coins']);
    return true;
  }

  Future<String> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString('Name');
    return name;
  }
  Future<String> getPass() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String pass = pref.getString('pass');
    return pass;
  }

  Future<int> getId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int id = int.parse(pref.getString('id'));
    return id;
  }

  Future<int> getCoins() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int coins = int.parse(pref.getString('coins'));
    return coins;
  }

  Future<int> getHiLevel() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int hiLevel = int.parse(pref.getString('hiLevel'));
    return hiLevel;
  }

  Future<int> getHiScore() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int hiScore = int.parse(pref.getString('hiScore'));
    return hiScore;
  }

  Future<bool> hasCacheData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.containsKey('id');
  }

  Future<void> setDefault() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Name','User_Sample');
    pref.setString('hiLevel', '0');
    pref.setString('hiScore', '0');
    pref.setString('coins', '0');
  }

}