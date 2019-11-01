import 'package:flutter_sqlite/database/db_provider.dart';
import 'package:flutter_sqlite/model/dog.dart';

class Repository {
  final DBProvider dbProvider = DBProvider();
  
  Future getAllDogs() => dbProvider.getAllDogs();
  Future insertDog(Dog dog) => dbProvider.newDog(dog);
  Future deleteDog(int id) => dbProvider.deleteDog(id);
  
}