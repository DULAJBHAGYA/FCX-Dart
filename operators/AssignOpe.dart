void main(){
    num num1 = 9;
    print(num1);

    num num2 = 2;
    print(num2);

    var d;
    d ??= num1/num2;
    print(d);

    d ??= num1-num2;
    print(d);
}