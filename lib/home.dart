import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toggle_list/toggle_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ToggleList(
        children: [
          ToggleListItem(
            title: const Text('I am the first item'),
            content: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Hello there!'),
            ),
          ),
          ToggleListItem(
            title: const Text('I am the second item'),
            content: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('I am delighted that you are here.'),
            ),
          ),
          ToggleListItem(
            title: const Text('I am the third item'),
            content: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Have a wonderful day!'),
            ),
          ),
        ],
      ),
    );
  }
}
