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

List<Stock> stock = [];

void getItems() {
  stdout.write('Enter an item or type "done" to finish adding items: ');
  String itemName = stdin.readLineSync()!;
  if (itemName.toLowerCase() == 'done') {
    print('Items entered:');
    displayItems();
    return;
  }

  stdout.write('Enter the price for $itemName: ');
  double itemPrice = double.parse(stdin.readLineSync()!);

  stdout.write('Enter the quantity for $itemName: ');
  int itemQuantity = int.parse(stdin.readLineSync()!);

  addItem(itemName, itemPrice, itemQuantity);
}

void addItem(String itemName, double itemPrice, int itemQuantity, [int? i]) {
  if (i != null && i >= 0 && i <= stock.length) {
    stock.insert(i, Stock(itemName, itemPrice, itemQuantity));
  } else {
    stock.add(Stock(itemName, itemPrice, itemQuantity));
  }
  print('Item "$itemName" added successfully.');
  getItems();
}

void displayItems() {
  print("Stock:");
  print("--------------------------------------------------");
  print("| ID |   Name              | Price     | Quantity |");
  print("--------------------------------------------------");
  for (int i = 0; i < stock.length; i++) {
    print("| ${i + 1}  | ${stock[i].name.padRight(20)} | \lkr${stock[i].price.toStringAsFixed(2).padLeft(8)} | ${stock[i].quantity.toString().padLeft(8)} |");
  }
  print("--------------------------------------------------");
  executeAction();
}

void deleteItem(int i) {
  try {
    if (i < 0 || i >= stock.length) {
      throw Exception("Invalid id");
    }
    Stock deletedItem = stock.removeAt(i);
    print("Item deleted successfully: ${deletedItem.name}");
    executeAction();
  } catch (error) {
    print(error.toString());
    executeAction();
  }
}

void deleteAllItems() {
  stock.clear();
  print("All items deleted.");
  executeAction();
}

void updateItem(int i, String newItem, double newPrice, int newQuantity) {
  try {
    if (i < 0 || i >= stock.length) {
      throw Exception("Invalid id");
    }
    stock[i].name = newItem;
    stock[i].price = newPrice;
    stock[i].quantity = newQuantity;
    print('Item at index ${i + 1} updated to "$newItem"');
    executeAction();
  } catch (error) {
    print(error.toString());
    executeAction();
  }
}

void saveToFile() {
  File file = File('stock.json');
  List<Map<String, dynamic>> jsonList =
      stock.map((item) => item.toJson()).toList();
  String jsonString = json.encode(jsonList);
  file.writeAsStringSync(jsonString);
  print('Stock saved to file.');
}

void loadFromFile() {
  File file = File('stock.json');
  if (!file.existsSync()) {
    print('No stock data found.');
    return;
  }

  String jsonString = file.readAsStringSync();
  List<dynamic> jsonList = json.decode(jsonString);
  stock = jsonList.map((itemJson) => Stock.fromJson(itemJson)).toList();
  print('Stock loaded from file.');
}

void executeAction() {
  stdout
      .write('Enter action (display/delete/deleteAll/update/add/done/save): ');
  String action = stdin.readLineSync()!;
  switch (action.toLowerCase()) {
    case 'display':
      displayItems();
      break;
    case 'delete':
      stdout.write('Enter the id of the item to delete: ');
      int i = int.parse(stdin.readLineSync()!) - 1;
      deleteItem(i);
      break;
    case 'deleteall':
      deleteAllItems();
      break;
    case 'update':
      stdout.write('Enter the id of the item to update: ');
      int iToUpdate = int.parse(stdin.readLineSync()!) - 1;
      stdout.write('Enter the new item name: ');
      String newItemName = stdin.readLineSync()!;
      stdout.write('Enter the new price: ');
      double newPrice = double.parse(stdin.readLineSync()!);
      stdout.write('Enter the new quantity: ');
      int newQuantity = int.parse(stdin.readLineSync()!);
      updateItem(iToUpdate, newItemName, newPrice, newQuantity);
      break;
    case 'add':
      getItems();
      break;
    case 'save':
      saveToFile();
      executeAction();
      break;
    case 'done':
      print('Exiting... ツ');
      break;
    default:
      print('Invalid action.');
      executeAction();
      break;
  }
}

void sellerFunctions() {
  loadFromFile();
  executeAction();
}

void main() {
  sellerFunctions();
}
