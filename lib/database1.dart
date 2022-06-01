import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

//データベース
class Memo {
  final int id;
  final String food;
  //final int count;
  final String date;

  Memo(
      {required this.id,
      required this.food,
      //required this.count,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id, //NOT NULL Primary Key
      'food': food,
      //'count': count,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, food:$food, date: $date}';
  }

  //count: $count,

  static Future<Database> get database async {
    // openDatabase() データベースに接続
    final Future<Database> _database = openDatabase(
      // getDatabasesPath() データベースファイルを保存するパス取得
      join(await getDatabasesPath(), 'memo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          // テーブルの作成
          "CREATE TABLE memo (id INTEGER PRIMARY KEY AUTOINCREMENT,food FOOD,date DATE)",
        );
      },
      version: 1,
    );
    return _database;
  }
  //count COUNT,

  static Future<void> insertMemo(Memo memo) async {
    final Database db = await database;
    await db.insert(
      'memo',
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Memo>> getMemos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('memo');
    return List.generate(maps.length, (i) {
      return Memo(
          id: maps[i]['id'],
          food: maps[i]['food'],
          //count: maps[i]['count'],
          date: maps[i]['date']);
    });
  }

  static Future<void> updateMemo(Memo memo) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      'memo',
      memo.toMap(),
      where: "id = ?",
      whereArgs: [memo.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> deleteMemo(int id) async {
    final db = await database;
    await db.delete(
      'memo',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
