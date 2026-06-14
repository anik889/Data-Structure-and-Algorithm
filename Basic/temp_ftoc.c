#include<stdio.h>
int main(){
    float f;
	printf("Enter temperature in Ferenheight : ");
	scanf(" %f ",&f);
	float c=(f-32)*(5/9);
	printf("Celcius temperature : %f\n",c);
    return 0;
    
}
