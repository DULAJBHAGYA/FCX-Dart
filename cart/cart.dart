import 'dart:convert';
import 'dart:io';

class Stock {
  late String name;
  late double price;
  late int quantity;

  Stock(this.name, this.price, this.quantity);

  Stock.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'].toDouble(),
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  @override
  String toString() {
    return '$name - Price: \lkr${price.toStringAsFixed(2)}, Quantity: $quantity';
  }
}

void displayStock(List<Stock> stock) {
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
  List<Map<String, dynamic>> jsonList = stock.map((item) => item.toJson()).toList();
  String jsonString = json.encode(jsonList);
  file.writeAsStringSync(jsonString);
  print('Data saved to $filename.');
}

void main() {
  List<Stock> stock = loadStockFromFile('stock.json');
  List<Stock> cart = loadStockFromFile('cart.json');
  
  while (true) {
    print('\nChoose an action:');
    print('1. Add item to cart');
    print('2. Delete item from cart');
    print('3. Update quantity of cart item');
    print('4. Delete all items in cart');
    print('5. Print invoice');
    print('6. Exit');
    
    stdout.write('Enter your choice: ');
    String choice = stdin.readLineSync()!;
    
    switch (choice) {
      case '1':
        stdout.write('Enter the item name: ');
        String itemName = stdin.readLineSync()!;
        
        Stock? foundStock;
        for (var item in stock) {
          if (item.name == itemName) {
            foundStock = item;
            break;
          }
        }
        
        if (foundStock == null) {
          print('Item not found in stock.');
          continue;
        }
        
        stdout.write('Enter the quantity: ');
        int quantityToAdd = int.parse(stdin.readLineSync()!);
        
        if (foundStock.quantity < quantityToAdd) {
          print('Insufficient quantity in stock.');
          continue;
        }
        
        foundStock.quantity -= quantityToAdd;
        
        Stock cartItem = Stock(itemName, foundStock.price, quantityToAdd);
        cart.add(cartItem);
        
        print('Item added to cart.');
        break;
        
      case '2':
        displayStock(cart);
        stdout.write('Enter the item index to delete: ');
        int indexToDelete = int.parse(stdin.readLineSync()!) - 1;
        
        if (indexToDelete < 0 || indexToDelete >= cart.length) {
          print('Invalid index.');
          continue;
        }
        
        Stock deletedItem = cart.removeAt(indexToDelete);
        print('Item deleted from cart: ${deletedItem.name}');
        
        break;
        
      case '3':
        displayStock(cart);
        stdout.write('Enter the item index to update: ');
        int indexToUpdate = int.parse(stdin.readLineSync()!) - 1;
        
        if (indexToUpdate < 0 || indexToUpdate >= cart.length) {
          print('Invalid index.');
          continue;
        }
        
        stdout.write('Enter the new quantity: ');
        int newQuantity = int.parse(stdin.readLineSync()!);
        
        Stock updatedItem = cart[indexToUpdate];
        int diff = newQuantity - updatedItem.quantity;
        
        if (diff > stock.where((item) => item.name == updatedItem.name).map((item) => item.quantity).single) {
          print('Insufficient quantity in stock.');
          continue;
        }
        
        updatedItem.quantity = newQuantity;
        stock.firstWhere((item) => item.name == updatedItem.name).quantity -= diff;
        
        print('Quantity updated.');
        
        break;
        
      case '4':
        cart.clear();
        print('All items deleted from cart.');
        break;
        
      case '5':
        double total = 0;
        print('Invoice:');
        for (var item in cart) {
          double itemTotal = item.price * item.quantity;
          total += itemTotal;
          print('${item.name} - ${item.price} LKR x ${item.quantity} = ${itemTotal} LKR');
        }
        print('Total: ${total} LKR');
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
