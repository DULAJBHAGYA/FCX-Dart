class std1 { 
void play() { 
	print("I am playing cricket"); 
} 
} 

class std2 extends std1 { 
@override 
void play() { 
	print("I am playing rugby"); 
} 
} 

void main() { 
std2 m = new std2(); 
m.play(); 
} 
