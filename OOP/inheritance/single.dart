class Bird {
  void fly() {
    print("I am flying");
  }
}

class Parrot extends Bird {
  void speack() {
    print("I am speaking");
  }
}

void main() {
  Parrot p = new Parrot();
  p.speack();
  p.fly();
}
