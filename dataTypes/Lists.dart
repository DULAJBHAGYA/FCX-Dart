void main() {
  List<int> list = [];
  
  list.add(12);
  list.add(13);
  list.add(11);
  
  print(list);

  print(list[1]);

  list.add(89);
  print(list);

  list.addAll([97,45]);
  print(list);

  list.insert(1, 67);
  print(list);

  list.remove(67);
  print(list);

  list.removeAt(2);
  print(list);

  list.removeLast();
  print(list);

  list.clear();
  print(list);

  list.addAll([97,13,56,67,78,98,45]);
  print(list);

  print(list.contains(56));

  print(list.indexOf(97));

  print(list.sublist(2, 5));


}
