#include<stdio.h>
int main(){
    float c;
	printf("Enter temperature in Celcius : ");
	scanf(" %f ",&c);
	float f=32+(c*(9/5));
	printf("Feranheight temperature : %f\n",f);
    return 0;
    
}
