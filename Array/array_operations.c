#include<stdio.h>
void insert_beginning(int arr[],int n){
    int value;
    printf("Enter the value : ");
    scanf("%d",&value);
    n++;
    for(int i=n;i>0;i--)
        arr[i]=arr[i-1];
    arr[0]=value;
}
void insert_end(int arr[], int n){
    int value;
    printf("Enter the value : ");
    scanf("%d",&value);
    n++;
    arr[n-1]=value;
}
void insert(int arr[], int n){
    int value, pos;
    printf("Enter the value and position : ");
    scanf("%d %d",&value,&pos);
    n++;
    for(int i=pos;i<n-1;i++)
        arr[i+1]=arr[i];
    arr[pos-1]=value;
}

void delete_beginning(int arr[],int n){
    for(int i=0;i<n-1;i++) 
        arr[i]=arr[i+1];
    n--;
}
void delete_end(int arr[], int n){
    n--;
}
void delete(int arr[],int n){
    int pos;
    printf("Enter the pos : ");
    scanf("%d",&pos);
    for(int i=pos-1;i<n;i++)
        arr[i]=arr[i+1];
    n--;
}
int main(){
    int n;
    printf("Enter the array size : ");
    scanf("%d",&n);
    int arr[n];
    printf("Enter the array elements : ");
    for(int i=0;i<n;i++)
        scanf("%d",&arr[i]);
}
