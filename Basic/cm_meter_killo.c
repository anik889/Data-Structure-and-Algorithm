#include<stdio.h>
int main(){
 	int a;
	printf("Enter the length : ");
	scanf(" %d",&a);
	printf("Value in meter : %d\n",(a/100));
	printf("Value in killometer : %d\n",((a/100)/1000));
   return 0;
}
