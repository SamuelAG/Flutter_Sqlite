class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  factory Dog.fromMap(Map<String, dynamic> json) => new Dog(id: json["id"], name: json["name"], age: json["age"]);

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "age" : age
  };

}