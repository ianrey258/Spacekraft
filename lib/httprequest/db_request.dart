import 'package:http/http.dart' as http;
import 'package:spacekraft/sharedpreference/sharedutil.dart';
import 'package:spacekraft/sqlite/userdata.dart';
import 'dart:convert';

abstract class RequestInit{
  Future<bool> checkAcess(String username,String password);
  Future<String> saveAccount(String username,String password);
  Future<List<UserData>> getByHiScore();
  Future<bool> updateData();
}

class DbRequest implements RequestInit{
  SharedUtil pref = new SharedUtil();

  Future<bool> checkAcess(String username,String password) async {
    var client = http.Client();
    try{
      var request = await client.get('https://ianrey.000webhostapp.com/SpacekraftUser/getData?Username='+username+'&Password='+password);
        if(request.statusCode==200){
          if(request.body.isNotEmpty){
            return await pref.setData(request.body);
          }else{
            return false;
          }
        } else {
          return false;
        }
    } finally{
      client.close();
    }
  }

  Future<String> saveAccount(String username,String password) async {
    var client = http.Client();
    try {
      var request = await client.post('https://ianrey.000webhostapp.com/SpacekraftUser',
                  body: {'Username' : username,'Password' : password});
        if(request.statusCode==200){
          return 'Success';
        }
        return 'Error';
    } finally {
      client.close();
    }
  }
  
  Future<List<UserData>> getByHiScore() async {
    var client = http.Client();
    try {
      var request = await client.get('https://ianrey.000webhostapp.com/SpacekraftUser/getHiScore');
        if(request.statusCode == 200){
          List jsonParse = json.decode(request.body);
          return (jsonParse).map((f) => UserData.fromMap(f)).toList();
        } else {
          throw('Failed to load');
        }
    } finally {
      client.close();
    }
    
  }

  Future<bool> updateData() async {
    var client = http.Client();
    int id = await  pref.getId();
    String name = await pref.getName();
    String pass = await pref.getPass();
    int hilvl = await  pref.getHiLevel();
    int hiscore = await  pref.getHiScore();
    int coins = await  pref.getCoins();
    try {
      var request = await client.post('https://ianrey.000webhostapp.com/SpacekraftUser',
                    body: {'id' : id.toString(),
                          'username' : name.toString(),
                          'password' : pass.toString(),
                          'hiLevel' : hilvl.toString(),
                          'hiScore' : hiscore.toString(),
                          'coins' : coins.toString(),});
      if(request.statusCode == 200){
        print('update');
        return true;
      } else {
        print('not update');
        return false;
      }
    } finally {
      client.close();
    }
    
  }

} 

