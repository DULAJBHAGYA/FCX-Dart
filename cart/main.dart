import 'dart:io';
import 'stock.dart';
import 'cart.dart';

void main() {
  stdout.write('Are you a customer or seller? (customer/seller) or enter exit to terminate process: ');
  String userType = stdin.readLineSync()!.toLowerCase();

  if (userType == 'seller') {
    sellerFunc();
  } else if (userType == 'customer') {
    customerFunc();
  } else if (userType == 'exit') {
    print('Exiting... ツ');
  }else {
    print('Invalid action.');
    main();
  }
}

void sellerFunc() {
  sellerFunctions();
}

void customerFunc() {
  customerFunction();
}
