#include<stdio.h>
#include<stdlib.h>

// ---------------- Structure Definition ----------------
struct node{
    int data;
    struct node *next;
};

// ---------------- Create a new node ----------------
struct node* createnode(int value){
    struct node *newnode=(struct node*)malloc(sizeof(struct node));
    if(newnode==NULL){                  // check malloc success
        printf("Memory Allocation Failed!\n");
        exit(1);
    }
    newnode->data=value;
    newnode->next=NULL;                 // fixed: was newnod->next (typo)
    return newnode;                     // fixed: was missing return
}

// ---------------- Insert at front ----------------
void push_front(struct node **head, int value){
    struct node *newnode=createnode(value);
    newnode->next=*head;
    *head=newnode;
}

// ---------------- Insert at back ----------------
void push_back(struct node **head, int value){
    struct node *newnode=createnode(value);
    if(*head==NULL){                    // empty list case
        *head=newnode;
        return;
    }
    struct node *temp=*head;
    while(temp->next!=NULL)
        temp=temp->next;
    temp->next=newnode;
}

// ---------------- Insert at given position (1-indexed) ----------------
void insert(struct node **head, int value, int position){
    if(position==1){                    // insert at front
        push_front(head, value);
        return;
    }
    if(*head==NULL){                    // nothing to walk through
        printf("Out Of Bound!\n");
        return;
    }

    struct node *newnode=createnode(value);
    struct node *temp=*head;            // fixed: was 'head' (missing *)
    int count=1;
    while(count<position-1 && temp!=NULL){
        temp=temp->next;
        count++;
    }
    if(temp==NULL){
        printf("Out Of Bound!\n");
        free(newnode);                  // avoid leaking the unused node
        return;
    }
    newnode->next=temp->next;
    temp->next=newnode;
}

// ---------------- Delete from front ----------------
void pop_front(struct node **head){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }
    struct node *temp=*head;
    *head=temp->next;
    free(temp);
}

// ---------------- Delete from back ----------------
void pop_back(struct node **head){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }
    if((*head)->next==NULL){            // fixed: Null -> NULL, only one node
        free(*head);
        *head=NULL;
        return;
    }
    struct node *temp=*head;
    while(temp->next->next!=NULL)       // stop at second-to-last node
        temp=temp->next;
    free(temp->next);
    temp->next=NULL;
}

// ---------------- Delete at given position (1-indexed) ----------------
void delete(struct node **head, int position){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }
    if(position==1){                    // delete front
        pop_front(head);
        return;
    }

    struct node *temp=*head;            // fixed: was 'head' (missing *)
    int count=1;                        // fixed: was undeclared 'count'
    while(count<position-1 && temp->next!=NULL){
        temp=temp->next;
        count++;
    }
    if(temp->next==NULL){               // fixed: check the node to delete, not temp
        printf("Out of Bounds!\n");
        return;
    }
    struct node *toDelete=temp->next;   // fixed: was deleting 'temp' itself
    temp->next=toDelete->next;
    free(toDelete);
}

// ---------------- Search for a value (returns position, 1-indexed) ----------------
int search(struct node *head, int value){
    struct node *temp=head;
    int position=1;
    while(temp!=NULL){
        if(temp->data==value)
            return position;
        temp=temp->next;
        position++;
    }
    return -1;                          // not found
}

// ---------------- Sort the list (ascending, bubble sort on data) ----------------
void sort(struct node *head){
    if(head==NULL) return;
    struct node *i, *j;
    for(i=head; i->next!=NULL; i=i->next){
        for(j=i->next; j!=NULL; j=j->next){
            if(i->data > j->data){
                int temp=i->data;       // swap data, not pointers
                i->data=j->data;
                j->data=temp;
            }
        }
    }
}

// ---------------- Print the list ----------------
void traverse(struct node *head){
    if(head==NULL){
        printf("List is empty!\n");
        return;
    }
    struct node *temp=head;
    while(temp!=NULL){
        printf("%d ",temp->data);
        temp=temp->next;
    }
    printf("\n");
}

int main(){
    struct node *head=NULL;             // fixed: was missing declaration

    push_back(&head, 10);
    push_back(&head, 20);
    push_back(&head, 30);
    traverse(head);                     // 10 20 30

    push_front(&head, 5);
    traverse(head);                     // 5 10 20 30

    insert(&head, 99, 3);
    traverse(head);                     // 5 10 99 20 30

    pop_front(&head);
    traverse(head);                     // 10 99 20 30

    pop_back(&head);
    traverse(head);                     // 10 99 20

    delete(&head, 2);                   // fixed: was called with 3 args
    traverse(head);                     // 10 20

    int pos=search(head, 20);
    printf("20 found at position: %d\n", pos);

    push_back(&head, 15);
    push_back(&head, 1);
    traverse(head);                     // 10 20 15 1
    sort(head);
    traverse(head);                     // 1 10 15 20

    pop_back(&head);
    pop_back(&head);
    pop_back(&head);
    pop_back(&head);
    traverse(head);                     // List is empty!

    pop_back(&head);                    // should print "List is empty!" not crash
    pop_front(&head);                   // should print "List is empty!" not crash

    return 0;
}
