class Dog {
  final int id;
  final String name;
  final int age;
  final int someValue;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.someValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      someValue: json['someValue'],
    );
  }

  @override
  String toString() {
    return 'Dog: id = $id, name = $name, age = $age';
  }
}
