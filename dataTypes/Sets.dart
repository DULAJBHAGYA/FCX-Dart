
void main(){
  var names = <String>{};

  names.add('dulaj');
  names.add('kelum');
  names.add('dasun');
  names.add('kamal');

  print(names);

  names.remove('kamal');

  print(names);

  print(names.length);

  print(names.contains('dulaj'));

  print(names.elementAt(1));

  names.remove('kelum');
  print(names);

  names.clear();
  print(names);


  names.add('dulaj');
  names.add('kelum');
  names.add('dasun');
  names.add('kamal');
  print(names);


  var cities = <String>{};

  cities.add('kandy');
  cities.add('colombo');
  cities.add('jaffna');

  print(cities);

  var set1 = names.union(cities);
  print(set1);

  var set2 = names.intersection(cities);
  print(set2);

  var set3 = names.difference(cities);
  print(set3);

}