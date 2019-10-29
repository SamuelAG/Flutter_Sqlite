import 'dart:math';

import 'package:flutter/material.dart';

import 'db_provider.dart';
import 'dog.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Dog> test = [
    Dog(id: 1, name: "samuel", age: 19),
    Dog(id: 2, name: "wally", age: 5),
    Dog(id: 3, name: "seila", age: 44),
    Dog(id: 4, name: "pingo", age: 22)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cachorros"),
      ),
      body: FutureBuilder<List<Dog>>(
          future: DBProvider.db.getAllDogs(),
          builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Dog item = snapshot.data[index];
                  return ListTile(
                    title: Text(item.name),
                    leading: Text(item.id.toString()),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Dog newDog = test[Random().nextInt(test.length)];
          await DBProvider.db.newDog(newDog);
          setState(() {});
        },
      ),
    );
  }
}
