//Problem 1: Write a C program to enter two numbers and perform all arithmetic operation
#include<stdio.h> 
int main(){
    int a,b;
    printf("Enter Numbers: ");
	scanf(" %d %d",&a,&b);
    printf("Addition : %d\n",(a+b));
    printf("Subtraction : %d\n",(a-b));
    printf("Multiplication : %d\n",(a*b));
    printf("Division : %d\n",(a/b));
   
}
