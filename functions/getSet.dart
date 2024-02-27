class Person {
  late String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}

void main() {
  var person = Person();
  person.name = "Alice";
  print(person.name);
}
