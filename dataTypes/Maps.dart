void main() {  
  var students = {
    'name': 'kamal', 
    'age': 12
    };

    print(students);

    print("\nget value from key record");
    print(students['name']);

    print("\nget specific record");
    print(students[0]);

    print("\nadd new record");
    students['city']  = 'kandy';
    print(students);

    print("\nupdate record");
    students['age'] = 25;
    print(students);

    print("\nremove record");
    students.remove('city');
    print(students);

    print(students.isEmpty);

    print(students.isNotEmpty);

    print(students.length);

    print(students.containsKey('age'));
    
    print(students.containsValue('kamal'));

   
}
