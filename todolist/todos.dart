import 'dart:convert';
import 'dart:io';

List<String> todolist = [];

void saveTasksToFile() {
  File file = File('todolist.json');
  List<Map<String, dynamic>> tasks = [];
  for (int i = 0; i < todolist.length; i++) {
    tasks.add({'id': i + 1, 'task': todolist[i]});
  }
  file.writeAsStringSync(jsonEncode(tasks));
}

void loadTasksFromFile() {
  File file = File('todolist.json');
  if (file.existsSync()) {
    List<dynamic> tasksJson = jsonDecode(file.readAsStringSync());
    todolist = tasksJson.map((task) => task['task'].toString()).toList();
  }
}

void getTasks() {
  loadTasksFromFile();
  stdout.write('Enter a task or type "done" to finish add tasks: ');
  String input = stdin.readLineSync()!;
  switch (input.toLowerCase()) {
    case 'done':
      print('Tasks entered: $todolist');
      saveTasksToFile();
      executeAction();
      break;
    default:
      addTask(input);
      break;
  }
}

void addTask(String task, [int? i]) {
  if (i != null && i >= 0 && i <= todolist.length) {
    todolist.insert(i, task);
  } else {
    todolist.add(task);
  }
  print('Task "$task" added successfully.');
  getTasks();
}

void displayTasks() {
  print("To do list -");
  print("-----------------------------");
  print("| ID | task                   |");
  print("------------------------------");
  for (int i = 0; i < todolist.length; i++) {
    print('|${i + 1}| | ${todolist[i]}|');
    print("-------------------------------");
  }
  executeAction();
}

void deleteTask(int i) {
  try {
    if (i < 0 || i >= todolist.length) {
      throw Exception("Invalid index");
    }
    String deletedTask = todolist.removeAt(i);
    print("Task deleted successfully: $deletedTask");
    saveTasksToFile();
    executeAction();
  } catch (error) {
    print(error.toString());
    executeAction();
  }
}

void deleteAllTasks() {
  todolist.clear();
  print("All tasks deleted.");
  saveTasksToFile();
  executeAction();
}

void updateTask(int i, String newTask) {
  try {
    if (i < 0 || i >= todolist.length) {
      throw Exception("Invalid index");
    }
    todolist[i] = newTask;
    print('Task at index ${i + 1} updated to "$newTask"');
    saveTasksToFile();
    executeAction();
  } catch (error) {
    print(error.toString());
    executeAction();
  }
}

void executeAction() {
  stdout.write('Enter action (display/delete/deleteAll/update/add/done): ');
  String action = stdin.readLineSync()!;
  switch (action.toLowerCase()) {
    case 'display':
      displayTasks();
      break;
    case 'delete':
      stdout.write('Enter the index of the task to delete: ');
      int i = int.parse(stdin.readLineSync()!) - 1;
      deleteTask(i);
      break;
    case 'deleteall':
      deleteAllTasks();
      break;
    case 'update':
      stdout.write('Enter the index of the task to update: ');
      int iToUpdate = int.parse(stdin.readLineSync()!) - 1;
      stdout.write('Enter the new task: ');
      String newTask = stdin.readLineSync()!;
      updateTask(iToUpdate, newTask);
      break;
    case 'add':
      stdout.write('Enter the task to add: ');
      String task = stdin.readLineSync()!;
      stdout.write('Enter the index to add the task (leave blank to add at the end): ');
      String? indexInput = stdin.readLineSync();
      int? index = indexInput!.isEmpty ? null : int.parse(indexInput) - 1;
      addTask(task, index);
      break;
    case 'done':
      print('Exiting ツ');
      break;
    default:
      print('Invalid action.');
      executeAction();
      break;
  }
}

void main() {
  getTasks();
}
