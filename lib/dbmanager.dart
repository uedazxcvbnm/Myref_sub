import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class dbmanager {
  late Database _database;

  Future opendb_mr() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "myref.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db
            .execute("CREATE TABLE myref(id INTEGER, count INTEGER, date TEXT");
      });
    }
  }

  Future opendb_mt() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "myref.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE material(id INTEGER, name TEXT, kana TEXT, category TEXT, exday INTEGER");
      });
    }
  }
}

class myref {
  int id;
  int count;
  String date;

  myref({required this.id, required this.count, required this.date});
  Map<String, dynamic> toMap() {
    return {'count': count, 'date': date};
  }
}

class material {
  int id;
  String name;
  String kana;
  String category;
  int exday;

  material(
      {required this.id,
      required this.name,
      required this.kana,
      required this.category,
      required this.exday});
  Map<String, dynamic> toMap() {
    return {'name': name, 'kana': kana, 'exday': exday};
  }
}
