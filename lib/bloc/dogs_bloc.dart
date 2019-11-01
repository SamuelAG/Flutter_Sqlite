import 'dart:async';
import 'package:flutter_sqlite/database/repository.dart';
import 'package:flutter_sqlite/model/dog.dart';
  
class DogsBloc  {

  final _repository = Repository();
  
  final _controller = StreamController<List<Dog>>.broadcast();

  get dogs => _controller.stream;
  
  DogsBloc() {
    getDogs();
  }

  getDogs() async {
    _controller.sink.add(await _repository.getAllDogs()); 
  }

  addDog(Dog dog) async {
    await _repository.insertDog(dog);
    getDogs();
  }

  deleteDog(int id) async {
    await _repository.deleteDog(id);
    getDogs();
  }

  dispose() {
    _controller.close();
  }

}