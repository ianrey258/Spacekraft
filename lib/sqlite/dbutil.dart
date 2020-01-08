import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbUtil{
  static Database _db;
  static const String DB_NAME = 'spacekraft.db';
  static const String TUSERDATA = 'userData';
  static const String TUSERSHIP = 'userShip';

  // Future<Database> get db async {
  //   if (_db != null) {
  //     return _db;
  //   }
  //   _db = await initDb();
  //   return _db;
  // }
 
  // initDb() async {
  //   io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, DB_NAME);
  //   var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  //   return db;
  // }
 
  // _onCreate(Database db, int version) async {
  //   await db
  //       .execute("CREATE TABLE $TUSERDATA ($ID INTEGER PRIMARY KEY, $TITLE TEXT,$ACTIVITY TEXT,$DATETIME TEXT)");
  // }
}