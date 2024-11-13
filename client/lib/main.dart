import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/presentation/chartpage.dart';
import 'package:front_end/presentation/filepick.dart';
import 'package:front_end/presentation/page.dart';
import 'package:http/http.dart' as http;

void main() {
  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Chartpage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String items = 'no items';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              height: 60,
              color: Colors.amber,
            ),
            ElevatedButton(
                onPressed: () {
                  callGetApi();
                },
                child: Text("getApi")),
            Container(
              child: Text(items),
              color: Colors.blue,
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void callGetApi() async {
    final String apiUrl = "http://localhost:8000/items/";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // レスポンスが成功した場合
      //debugPrint("http succes");
      // UTF-8としてデコード
      final decodedResponse = utf8.decode(response.bodyBytes);
      debugPrint(response.body);
      // JSONをデコード
      final item = json.decode(decodedResponse);
      debugPrint(item.toString());
      setState(() {
        items = item;
      });
    } else {
      // エラー処理
      throw Exception('Failed to load items');
    }
  }

  Widget mycenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Container(
            height: 60,
            color: Colors.amber,
          ),
          ElevatedButton(
              onPressed: () {
                callGetApi();
              },
              child: Text("getApi")),
          Container(
            child: Text(items),
            color: Colors.blue,
            height: 100,
          )
        ],
      ),
    );
  }
}
