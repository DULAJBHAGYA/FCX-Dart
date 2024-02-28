class Box<T> {
  T value;

  Box(this.value);

  T getValue() {
    return value;
  }
}

void main() {
  Box<int> intBox = Box<int>(10);
  int intValue = intBox.getValue();
  print(intValue); 

  Box<String> stringBox = Box<String>('Hello');
  String stringValue = stringBox.getValue();
  print(stringValue); 
}