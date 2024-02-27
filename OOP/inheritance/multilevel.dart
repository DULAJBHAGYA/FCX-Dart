class fish {
  void swim() {
    print("I am swimming");
  }
}

class duck extends fish {
  void shout() {
    print("I am shouting");
  }
}

class man extends duck {
  void eat() {
    print("I am eating");
  }
}

void main() {
  man p = new man();
  p.eat();
  p.swim();
  p.shout();
}
