import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storages/dog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final prefs = await SharedPreferences.getInstance();
  //
  // await prefs.setInt('my int', 999);
  // await prefs.setString('my string', 'some value');
  //
  // // final value = prefs.get('my string');
  // // print(value);
  //
  // // await prefs.remove('my int');
  // // await prefs.clear();
  //
  // print(prefs.containsKey('my string'));
  //
  // for (final key in prefs.getKeys()) {
  //   print(prefs.get(key));
  // }

  // const storage = FlutterSecureStorage();
  //
  // await storage.write(key: 'my value', value: '2134234');
  //
  // // final value = await storage.read(key: 'my value');
  // final value = await storage.readAll();
  // print(value);
  //
  // await storage.delete(key: 'my value');
  // await storage.containsKey(key: 'my key');

  // final Directory directory = await getApplicationDocumentsDirectory();
  // final String path = directory.path;
  // final file = File('$path/some_file.txt');
  //
  // // await file.writeAsString('Some content');
  //
  // final content = await file.readAsString();
  // print(content);

  final databasePath = '${await getDatabasesPath()}/dog_database.db';

  final database = await openDatabase(
    databasePath,
    onCreate: (db, version) {
      return db.execute('CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    },
    version: 1,
  );

  // const dog = Dog(id: 1, name: 'Fido', age: 2);
  // await database.insert('dogs', dog.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

  // const dogToUpdate = Dog(id: 1, name: 'Fido', age: 6);
  // await database.update('dogs', dogToUpdate.toJson(), where: 'id = ?', whereArgs: [1]);

  await database.delete('dogs', where: 'id = ?', whereArgs: [1]);


  final dogs = await database.query('dogs');
  final dog = Dog.fromJson(dogs.first);
  print(dog);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        child: Material(
          child: Column(
            children: [
              Text('Title'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text('Dialog title'),
    //         content: Text('Description'),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text('Cancel')),
    //           ElevatedButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 // ...
    //               },
    //               child: Text('OK')),
    //         ],
    //       );
    //     });

    // final result = await showDialog(
    //   context: context,
    //   builder: (context) => TimePickerDialog(
    //     initialTime: TimeOfDay(hour: 12, minute: 0),
    //
    //   ),
    // );
    // print(result);

    // final date = await showDialog(
    //   context: context,
    //   builder: (context) => Column(
    //     children: [
    //       DatePickerDialog(
    //         initialDate: DateTime.now(),
    //         firstDate: DateTime(1900, 1, 1),
    //         lastDate: DateTime.now(),
    //       ),
    //       TimePickerDialog(
    //         initialTime: TimeOfDay(hour: 12, minute: 0),
    //       ),
    //     ],
    //   ),
    // );
    // print(date);

    final result = await showDialog(context: context, builder: (context) => MyDialog());
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
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
}
