#include<stdio.h>
int main(){
    float a,b,c,d,e;
	printf("Enter the marks : ");
	scanf(" %f  %f %f %f %f ",&a,&b,&c,&d,&e);
	float t,avr;
	t=a+b+c+d+e;
	avr=t/5;
	printf("Total and Average marks are : %f %f\n",t,avr);
    return 0;
    
}
