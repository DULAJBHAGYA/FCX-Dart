class student {
  var stdName;
  var stdAge;

  showStdInfo() {
    print("My name is ${stdName}");
    print("My age is ${stdAge}");
  }
}

void main() {
  var std = new student();

  std.stdName = 'Dulaj';
  std.stdAge = 25;

  std.showStdInfo();
}
