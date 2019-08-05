
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class Helper{
  static final Helper _helper=Helper.internal();
  Helper.internal();
  static Database _database;

  factory Helper()=> _helper;

  Future<Database> get database async{
    if(_database!=null){
      return _database;
    }
    _database=await initDB();
    return _database;
  }
initDB()async{
    String databasepath=await getDatabasesPath();
    String path=join(databasepath,'note.db');
      var base= await openDatabase(path, version: 1, onCreate: _OnCreate);
      return base;
}
  
void _OnCreate(Database db, int version)async{
   await db.execute("create table Tareas( _id integer primary key autoincrement,  title text ,  descripcion text, prioridad integer);");
    
}

Future <int> Insert(Map <String,dynamic>map)async{
    Database DB=await database;
    var result= await DB.insert("Tareas", map);
    return result;
}
Future <int> BDUpdate(List<int> id,Map<String, dynamic> map)async{
 Database DB=await database;
   var result= await DB.update("Tareas", map,where: "_id=?",whereArgs: id);
    return result;
}

Future <int> BDDelete(List<int> id) async{
 Database DB=await database;
   var result= await DB.delete("Tareas", where: "_id=?", whereArgs: id);
    return result;


}
Future<List<Map<String,dynamic>>> Select() async{
    Database DB=await database;
    var result= await DB.query("Tareas");
    return result;
}

Future<int> Count()async{
Database DB=await database;
List<Map<String,dynamic>> mapa=List<Map<String,dynamic>>();
mapa=await DB.query("Tareas");
int dato=mapa.length;
return dato;
  }







}