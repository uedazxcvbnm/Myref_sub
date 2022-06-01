import 'package:flutter/material.dart';
import './page1.dart';
import './page2.dart';
/*import './page3.dart';
import './page4.dart';*/
import './database1.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
//import 'package:flutter/services.dart';
//import 'dart:io';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';

//BottomNavigationBarを使いたい
void main() => runApp(const MyApp());

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'BottomNavBar Code Sample';
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  //constが必要
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final _childPageList = [
    MyHomePage(),
    NextPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEMO'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _childPageList,
      ),

      // 下のナビゲーションボタン
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            //Flutter2なのでここではlabelを使うべきxedStack(
            //そしてlabelは必須
            label: 'ラベル1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'ラベル2',
          ),
        ],
        // 選択したときはオレンジ色にする
        selectedItemColor: Colors.amber[800],
        // タップできるように
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  var _selectedValue = '機能１';
  var _usStates = ["機能１", "機能２", "機能３"];
  //_counter定義
  int _counter = 0;
  //int count = 0;
  //int index1 = 0;
  int _selectedIndex = 0;
  List<Memo> _memoList = [];
  int index = 0;
  //id番号
  var _selectedvalue_id;
  //非同期関数定義
  Future<void> initializeDemo() async {
    _memoList = await Memo.getMemos();
  }
  /*final prefs = await SharedPreferences.getInstance();
  prefs.setString('count', count);*/

  final myController = TextEditingController();
  //カウントアップ定義
  int apple_counter = 0;
  int orange_counter = 0;
  int strawberry_counter = 0;
  void _incrementAppleCounter() {
    setState(() {
      apple_counter++;
    });
  }

  void _incrementOrangeCounter() {
    setState(() {
      orange_counter++;
    });
  }

  void _incrementStrawberryCounter() {
    setState(() {
      strawberry_counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /*static List<Widget> _widgetOptions = <Widget>[
    // ページ1の画面
    MyStatefulWidget(),
    // ページ2の画面
    NextPage(),
  ];*/

  final List<TabInfo> _tabs = [
    //TabInfo("頻繁に買う食品", Page4()),
    TabInfo("野菜・果物", Page1()),
    TabInfo("肉・魚", Page2()),
    //TabInfo("インスタント食品", Page3()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      //title: 'Grid List',
      child: Scaffold(
        appBar: AppBar(
          title: Text('賞味期限管理アプリ'),
          //アイコンボタンの表示はactions:<Widget>が必要
          actions: <Widget>[
            //とりあえずアイコンボタン
            IconButton(
              icon: Icon(Icons.android),
              onPressed: () {},
            ),
            //appbar メニューボタン
            PopupMenuButton<String>(
              initialValue: _selectedValue,
              onSelected: (String s) {
                setState(() {
                  _selectedValue = s;
                });
              },
              itemBuilder: (BuildContext context) {
                return _usStates.map((String s) {
                  return PopupMenuItem(
                    child: Text(s),
                    value: s,
                  );
                }).toList();
              },
            ),
          ],
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
        //body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),

        body: Center(
          child: FutureBuilder(
            future: initializeDemo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 非同期処理未完了 = 通信中
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, //カラム数
                ),
                //itemCount: _memoList.length,
                itemCount: 1,
                itemBuilder: (context, index_id) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$apple_counter',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "りんご indexNum: $_selectedIndex",
                            ),
                            IconButton(
                              onPressed: _incrementAppleCounter,
                              icon: Icon(Icons.add),
                              iconSize: 20,
                            ),
                          ],
                        ),
                        Text(
                          '$orange_counter',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "みかん count: $orange_counter",
                            ),
                            IconButton(
                              onPressed: _incrementOrangeCounter,
                              icon: Icon(Icons.add),
                              iconSize: 20,
                            ),
                          ],
                        ),
                        Text(
                          '$strawberry_counter',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "いちご indexNum: $_selectedIndex",
                            ),
                            IconButton(
                              onPressed: _incrementStrawberryCounter,
                              icon: Icon(Icons.add),
                              iconSize: 20,
                            ),
                          ],
                        ),
                        /*app_grid12
                        /*const Text(
                              'You have pushed the button this many times:',
                            ),*/

                        //index_id データベースのindex
                        //Text('ID ${_memoList[index_id].id}'),
                        Text('COUNT${_memoList[index_id].count}'),
                        Text('DATE${_memoList[index_id].date}'),
                        //style: Theme.of(context).textTheme.headline4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "indexNum: $_selectedIndex",
                            ),
                            IconButton(
                              onPressed: _incrementCounter,
                              icon: Icon(Icons.add),
                              iconSize: 20,
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  );
                },
              );
            }, //),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          //onPressed: _incrementCounter,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text("新規メモ作成"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('なんでも入力してね'),
                          TextField(controller: myController),
                          ElevatedButton(
                            child: Text('保存'),
                            onPressed: () async {
                              Memo _memo = Memo(
                                  id: _selectedvalue_id,
                                  food: 'りんご',
                                  //count: _counter,
                                  date: myController.text);
                              await Memo.insertMemo(_memo);
                              final List<Memo> memos = await Memo.getMemos();
                              setState(() {
                                _memoList = memos;
                                _selectedvalue_id = null;
                              });
                              myController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

// Nextページ
class NextPage extends StatefulWidget {
  //static const routeName = '/next';

  const NextPage({Key? key}) : super(key: key);
  //final String title;
  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int _counter = 0;
  //Object? args; //argsの受け取り用
  int _selectedIndex = 0;
  int count = 0;
  //カウントアップ定義
  void _incrementCounter() async {
    /*Memo _memo = Memo(id: 0, count: count++); //date: '2022/1/1'
    await Memo.updateMemo(_memo);
    setState(() {
      count++;
    });*/
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //削除
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // argumentsを受け取る --->
    // ※setStateの度にbuildが呼ばれるので初回(asrgがnull)の時だけ受け取る
    /*if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments;
      _counter = args as int; //Object型なので型を指定する
    }*/

    return Scaffold(
      appBar: AppBar(
          //title: Text(widget.title),
          ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          //表示する要素数
          1,
          (index) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*const Text(
                    'You have pushed the button this many times:',
                  ),*/
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "りんご indexNum: $_selectedIndex",
                      ),
                      IconButton(
                        onPressed: _incrementCounter,
                        icon: Icon(Icons.done),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  //みかん
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "みかん indexNum: $_selectedIndex",
                      ),
                      IconButton(
                        onPressed: _incrementCounter,
                        icon: Icon(Icons.done),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  //いちご
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "いちご indexNum: $_selectedIndex",
                      ),
                      IconButton(
                        onPressed: _incrementCounter,
                        icon: Icon(Icons.done),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      //ボトムナビゲーションバー　これは使わない
      /*
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: [
          //タブ
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ラベル1',
            //tooltip: "This is a Book Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ラベル2',
            tooltip: "This is a B Page",
          ),
        ],
        onTap: (index) async {
          RouteSettings settings = RouteSettings(arguments: _counter);
          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              settings: settings,
              builder: (context) => NextPage(title: 'Next'),
            ),
          );
          setState(() {
            _counter = result as int;
          });
        },
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}




//ボトムナビゲーションバー　使わないもの
        /*bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          items: [
            //タブ
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ラベル1',
              tooltip: "This is a Book Page",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ラベル2',
              tooltip: "This is a B Page",
            ),
          ],
          /*onTap: (index) async {
            RouteSettings settings = RouteSettings(arguments: _counter);
            var result = await Navigator.of(context).push(
              MaterialPageRoute(
                settings: settings,
                builder: (context) => NextPage(title: 'Next'),
              ),
            );
            setState(() {
              _counter = result as int;
            });
          },*/
        ),*/