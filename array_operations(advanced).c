#include <stdio.h>

#define MAX 100

int arr[MAX];
int size = 0;   // current number of elements actually in use

// ---------- INSERT AT BEGINNING ----------
void insertFront(int value){
    if(size >= MAX){
        printf("Array is full\n");
        return;
    }
    // shift everything one step to the right, starting from the back
    for(int i = size; i > 0; i--){
        arr[i] = arr[i-1];
    }
    arr[0] = value;
    size++;
}

// ---------- INSERT AT END ----------
void insertBack(int value){
    if(size >= MAX){
        printf("Array is full\n");
        return;
    }
    arr[size] = value;   // no shifting needed
    size++;
}

// ---------- INSERT AT ANY POSITION (1-indexed) ----------
void insertAt(int value, int position){
    if(size >= MAX){
        printf("Array is full\n");
        return;
    }
    if(position < 1 || position > size + 1){
        printf("Invalid position\n");
        return;
    }
    // shift everything from the end up to 'position' one step right
    for(int i = size; i >= position; i--){
        arr[i] = arr[i-1];
    }
    arr[position-1] = value;   // -1 because arrays are 0-indexed, positions are 1-indexed
    size++;
}

// ---------- DELETE FROM BEGINNING ----------
void deleteFront(){
    if(size == 0){
        printf("Array is empty\n");
        return;
    }
    // shift everything one step to the left
    for(int i = 0; i < size-1; i++){
        arr[i] = arr[i+1];
    }
    size--;
}

// ---------- DELETE FROM END ----------
void deleteBack(){
    if(size == 0){
        printf("Array is empty\n");
        return;
    }
    size--;   // no shifting needed — just "forget" the last slot
}

// ---------- DELETE FROM SPECIFIC POSITION (1-indexed) ----------
void deleteAt(int position){
    if(size == 0){
        printf("Array is empty\n");
        return;
    }
    if(position < 1 || position > size){
        printf("Invalid position\n");
        return;
    }
    // shift everything after 'position' one step left
    for(int i = position-1; i < size-1; i++){
        arr[i] = arr[i+1];
    }
    size--;
}

// ---------- DISPLAY ----------
void print(){
    if(size == 0){
        printf("Array is empty\n");
        return;
    }
    for(int i = 0; i < size; i++){
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main(){
    insertBack(10);
    insertBack(20);
    insertBack(30);
    print();              // 10 20 30

    insertFront(5);
    print();              // 5 10 20 30

    insertAt(15, 3);
    print();              // 5 10 15 20 30

    deleteFront();
    print();              // 10 15 20 30

    deleteBack();
    print();              // 10 15 20

    deleteAt(2);
    print();              // 10 20

    return 0;
}
