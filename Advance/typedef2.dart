typedef MultiOperation(int num1, int num2);    
  
Sum(int n1, int n2) {  
      print("Sum of the two number:${n1+n2}");  
}  
Sub(int n1, int n2 ) {  
      print("Subtraction of the two number:${n1-n2}");  
}  
   
NumericOperation(int n1, int n2, MultiOperation mp){  
      print("Inside Operation");  
      mp(n1,n2);  
         }  
  
void main() {  
print("JavaTpoint - Dart typedef Example");  
NumericOperation(20, 10, Sum);  
NumericOperation(20, 10, Sub);  
}  