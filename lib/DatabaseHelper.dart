import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper
{
  static final DatabaseHelper instance = DatabaseHelper();
  static final dbName = 'new_new_nvcvvsjvdasdssnzxzbc';
  static final dbVersion = 1;
  static final tableName = 'user_credentials';
  static final user_id = 'user_id';
  static final Autorization = 'Authorization';

  
static Database _database;

  Future<Database> get database async
  {
    if(_database != null)
    {
      return _database;
    }
else if(_database == null)
{
    _database = await _initiateDatabase();
    return _database;
}
  }

Future _initiateDatabase()
  async
  {
      debugPrint('initialize database method chal raha hai');
    Directory directory  = await getApplicationDocumentsDirectory();
  String path =  join(directory.path,dbName);
  return await openDatabase(path,version: dbVersion,onCreate: 
  (Database db,int version)
async
  {
    debugPrint('create table chal raha hai');
   await db.execute(
    '''
    CREATE TABLE $tableName(
      $user_id INTEGER NOT NULL,
      $Autorization TEXT NOT NULL

    )
    ''');
  }

  
  );
  }

//   Future _onCreate(Database database_db,int version)
// async
//   {
//    await database_db.execute(
//     '''
//     CREATE TABLE $tableName(
//       $user_id INTEGER PRIMARY KEY,
//       $Autorization TEXT NOT NULL,

//     )
//     ''');
//     debugPrint('create table chal raha hai');
//   }

  Future insert(Map<String,dynamic> mapData)
  async
  {
    Database db =await instance.database ;
    await db.insert(tableName, mapData);
  }

  Future<Map<String,dynamic>> fetch()
  async
  {
    Database db = await instance.database;
   List<Map<String,dynamic>> listOfMaps= await db.query(tableName);
   return listOfMaps[0];
    // return db;
  }

  Future delete()
  async
  {
    Database db = await instance.database;
    await db.delete(tableName);
  }
  initializeDatabaseToNull()
  async
   {
     Database db =await instance.database;
      db = null;
    //  db.close();
  }

}