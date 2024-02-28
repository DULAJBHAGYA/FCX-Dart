class Animal {
  Animal(String animal_name) {
    print("Hello ${animal_name}");
  }
}

class Dog extends Animal {
  Dog() : super("Dog") {
    print("Dog");
  }
}

void main() {
  Dog d = Dog();
}
