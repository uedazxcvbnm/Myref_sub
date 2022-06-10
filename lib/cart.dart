import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// class shoppingCart {
//   Future _openDb() async {
//     final databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'myref.db');
//   }
// }

class Cart extends StatelessWidget {
  //const Cart({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
        child: Text('cart'),
      ));
}
