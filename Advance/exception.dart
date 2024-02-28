void main() {
  void divide(int x, int y) {
    try {
      double result = x / y;
      print("Division result: $result");
    } on IntegerDivisionByZeroException {
      print("Error: Cannot divide by zero!");
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      print("Division operation completed.");
    }
  }

  print("Case 1:");
  divide(10, 2);
  print("\nCase 2:");
  divide(10, 0);
  divide(10, 'a' as int);
}
