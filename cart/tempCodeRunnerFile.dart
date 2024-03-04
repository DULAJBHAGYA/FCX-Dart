import 'dart:convert';
import 'dart:io';
import 'stock.dart';

void displayStock(List<Stock> stock) {
  print("Stock -");
  for (int i = 0; i < stock.length; i++) {
    print('${i + 1} - ${stock[i]}');
  }
}

void displayCart(List<Stock> cart) {
  print("Cart -");
  for (int i = 0; i < cart.length; i++) {
    print('${i + 1} - ${cart[i]}');
  }
}

void displayItems(List<Stock> stock) {
  print("Stock -");
  for (int i = 0; i < stock.length; i++) {
    print('${i + 1} - ${stock[i]}');
  }
}

List<Stock> loadStockFromFile(String filename) {
  File file = File(filename);
  if (!file.existsSync()) {
    print('No data found.');
    return [];
  }

  String jsonString = file.readAsStringSync();
  List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((itemJson) => Stock.fromJson(itemJson)).toList();
}

void saveStockToFile(List<Stock> stock, String filename) {
  File file = File(filename);
  List<Map<String, dynamic>> jsonList =
      stock.map((item) => item.toJson()).toList();
  String jsonString = json.encode(jsonList);
  file.writeAsStringSync(jsonString);
  print('Data saved to $filename.');
}

void checkout(List<Stock> cart) {
  double total = 0;
  print('Invoice -');
  for (var item in cart) {
    double itemTotal = item.price * item.quantity;
    total += itemTotal;
    print(
        '${item.name} - ${item.price} LKR x ${item.quantity} = ${itemTotal} LKR');
  }
  print('Total: ${total} LKR');

  stdout.write('Proceed with transaction? (yes/no): ');
  String proceed = stdin.readLineSync()!;
  if (proceed.toLowerCase() == 'yes') {
    print('Transaction successful.');
    print('Cart cleared.');
    cart.clear();
  }
}

void caseFunction(List<Stock> stock, List<Stock> cart) {
  while (true) {
    print('\nChoose action you want to perform:');
    print('1. Add item to cart');
    print('2. Delete item from cart');
    print('3. Update quantity of cart item');
    print('4. Delete all items in cart');
    print('5. Checkout');
    print('6. Exit');

    stdout.write('Enter your choice: ');
    String choice = stdin.readLineSync()!;

    switch (choice) {
      case '1':
        displayStock(stock);
        stdout.write('Enter the index of the item to add to cart: ');
        int index = int.parse(stdin.readLineSync()!) - 1;
        if (index >= 0 && index < stock.length) {
          Stock selectedItem = stock[index];
          stdout.write('Enter quantity to add to cart: ');
          int quantity = int.parse(stdin.readLineSync()!);
          if (selectedItem.quantity >= quantity) {
            selectedItem.quantity -= quantity;
            Stock cartItem = Stock(
              selectedItem.name,
              selectedItem.price,
              quantity,
            );
            cart.add(cartItem);
            print('Item added to cart.');
          } else {
            print('Insufficient stock.');
          }
        } else {
          print('Invalid index.');
        }
        break;

      case '2':
        displayCart(cart);
        stdout.write('Enter the index of the item to delete from cart: ');
        int index = int.parse(stdin.readLineSync()!) - 1;
        if (index >= 0 && index < cart.length) {
          Stock deletedItem = cart.removeAt(index);
          print('Item deleted from cart: ${deletedItem.name}');
        } else {
          print('Invalid index.');
        }
        break;

      case '3':
        displayCart(cart);
        stdout.write('Enter the index of the item to update quantity: ');
        int index = int.parse(stdin.readLineSync()!) - 1;
        if (index >= 0 && index < cart.length) {
          Stock selectedItem = cart[index];
          stdout.write('Enter the new quantity: ');
          int newQuantity = int.parse(stdin.readLineSync()!);
          if (newQuantity <= selectedItem.quantity) {
            selectedItem.quantity = newQuantity;
            print('Quantity updated.');
          } else {
            print('Insufficient stock.');
          }
        } else {
          print('Invalid index.');
        }
        break;

      case '4':
        cart.clear();
        print('All items deleted from cart.');
        break;

      case '5':
        checkout(cart); // Display invoice and proceed with transaction
               saveStockToFile(stock, 'stock.json'); // Save stock after transaction
        saveStockToFile(cart, 'cart.json');
        break;

      case '6':
        saveStockToFile(stock, 'stock.json');
        saveStockToFile(cart, 'cart.json');
        print('Exiting...');
        exit(0);

      default:
        print('Invalid choice.');
        break;
    }
  }
}

void customerFunction() {
  List<Stock> stock = loadStockFromFile('stock.json');
  List<Stock> cart = loadStockFromFile('cart.json');
  caseFunction(stock, cart);
}

void main() {
  customerFunction();
}
