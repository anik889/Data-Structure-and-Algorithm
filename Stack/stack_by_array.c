#include<stdio.h>
#define size 100        // maximum capacity of the stack
int stack[size];         // array-based stack storage
int top=-1;               // index of the top element; -1 means empty
// pushes a value onto the top of the stack
void push(int value){
    if(top>=size-1)                       // no room left
        printf("Size Overflow\n");
    else{
        top++;                             // move top up first...
        stack[top]=value;                  // ...then place the value there
        printf("%d has been inserted at the back\n", value);
    }
}
// removes the value at the top of the stack
void pop(){
    if(top<=-1)                            // nothing to remove
        printf("Stack Underflow\n");
    else{
        printf("%d has been poped out from back\n", stack[top]); // read before removing
        top--;                              
        // logically removes it (data still sits in the array, but is now out of bounds of the "active" stack region)
    }
}
// prints the stack from top to bottom
void display(){
    if(top==-1)
        printf("Stack is empty\n");
    else{
        for(int i=top;i>=0;i--)
            printf("%d ",stack[i]);
        printf("\n");
    }
}
int main(){
    int n;
    scanf("%d",&n);                        // how many values to push
    for(int i=0;i<n;i++){
        int k;
        scanf("%d",&k);
        push(k);
    }
    display();
    int x;
    scanf("%d",&x);                        // how many times to pop
    for(int i=0;i<x;i++){
        pop();                              
    // pop always removes the current top; it doesn't take an argument, so no value needs to be read here
    }
    display();
    return 0;
}
