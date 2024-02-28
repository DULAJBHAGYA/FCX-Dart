class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);
  double calculateArea() {
    return width * height;
  }
}

void main() {
  Rectangle myRectangle = Rectangle(5, 3);
  
  double area = myRectangle.calculateArea();
  print('Area: $area');  
  }