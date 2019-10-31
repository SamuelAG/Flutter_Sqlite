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
    Dog(id: 1, name: "Bores", age: 19),
    Dog(id: 2, name: "Wally", age: 5),
    Dog(id: 3, name: "Seila", age: 44),
    Dog(id: 4, name: "Pingo", age: 22)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("Cachorros"),
      ),
      body: Container(
        color: Colors.blueGrey[300],
        child: FutureBuilder<List<Dog>>(
            future: DBProvider.db.getAllDogs(),
            builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Dog item = snapshot.data[index];
                    return Dismissible(
                      direction: DismissDirection.startToEnd,
                      onDismissed: (diretion) {
                        DBProvider.db.deleteDog(item.id);
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                          borderRadius: BorderRadiusDirectional.circular(10.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 18, 0, 8),
                          child: Text(
                            "DELETE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        //color: Colors.red,
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),
                          ),
                          leading: Text(item.id.toString(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      key: UniqueKey(),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[700],
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
