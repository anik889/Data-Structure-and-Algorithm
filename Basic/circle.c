#include <stdio.h>
int main() {
    float r;
	printf("Enter Radius : ");
	scanf(" %d",&r);
	float area = 3.1416*r*r;
	float circum=2*3.1416*r;
	printf("Area : %f",area);
	printf("Circumference : %f",circum);
	return 0;
}
