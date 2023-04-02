import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final _databasename = "person.db";
  static final _databaseversion = 1;

  static final table = 'my_table';

  static final ColumnId = 'id';
  static final ColumnName = 'name';
  static final ColumnAge = 'age';

  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  // Future<Database> get databse async{
  //   if(_database != null) return _database;
  //
  //   _database =await _initDatabase();
  //   return _database;

  Future<Database> get databse async {
    return _database ??= await _initDatabase();
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $table(
 $ColumnId INTEGER PRIMARY KEY,
 $ColumnName TEXT NOT NULL,
 $ColumnAge INTEGER NOT NULL 
  )
  ''');
  }

  // function to insert,query,update & delete
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.databse;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.databse;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database db = await instance.databse;
    var res = await db.query(table, where: "age <?", whereArgs: [age]);

    // var res = await db.rawQuery('SELECT * FROM table WHERE age >?', [age]);
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.databse;

    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
