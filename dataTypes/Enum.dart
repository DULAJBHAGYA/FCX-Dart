enum months{
  january,
  february,
  march,
  april,
  may,
  june,
  july
}

void main(){
  for(var month in months.values){
  print(month);
  }

  print("\nprint enum values");
  print(months.values);

print("\ngetting enum string representation");
var monthString = months.may.toString();
print(monthString); 

print("\nswitch case with enum");
var month = months.july;

switch (month) {
    case months.may:
        print('May');
        break;
    case months.april:
        print('April');
        break;
    case months.january:
        print('January');
        break;
    default:
        print('Unknown month');
        break;
}


}