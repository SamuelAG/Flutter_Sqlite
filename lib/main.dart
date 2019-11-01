import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/bloc/dogs_bloc.dart';
import 'model/dog.dart';

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

  final DogsBloc bloc = DogsBloc();

  Widget buildList(BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
    if(snapshot.data != null) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          Dog item = snapshot.data[index];
          return Dismissible(
            direction: DismissDirection.startToEnd,
            onDismissed: (diretion) {
              bloc.deleteDog(item.id);
            },
            background: Container(
              decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadiusDirectional.circular(10.0)),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: Text(item.id.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            key: UniqueKey(),
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator(),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("Cachorros"),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.redAccent[700],
            ),
            accountName: Text("Samuel Alves"),
            accountEmail: Text("samuel.alvesg@hotmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text("Item 1"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: Text("Item 2"),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      )),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: bloc.dogs,
          builder: buildList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[700],
        child: Icon(Icons.add),
        onPressed: () async {
          Dog newDog = test[Random().nextInt(test.length)];
          bloc.addDog(newDog);
        },
      ),
    );
  }
}
