#include<stdio.h>
#include<stdlib.h>

// ---------------- Structure Definition ----------------
// each node holds an integer value and a pointer to the next node
struct node{
    int data;
    struct node *next;
};

// ---------------- Create a new node ----------------
// allocates memory for a node, fills in its data, sets next to NULL,
// and returns the address of the new node
struct node* createnode(int value){
    struct node *newnode=(struct node*)malloc(sizeof(struct node));
    if(newnode==NULL){
        printf("Memory Allocation Failed!\n");
        exit(1);
    }
    newnode->data=value;
    newnode->next=NULL;
    return newnode;
}

// ---------------- Insert at front ----------------
// creates a new node and makes it the new head of the list
void push_front(struct node **head, int value){
    struct node *newnode=createnode(value);
    newnode->next=*head;
    *head=newnode;
}

// ---------------- Insert at back ----------------
// walks to the last node and attaches the new node after it;
// handles the empty-list case separately (new node becomes head)
void push_back(struct node **head, int value){
    struct node *newnode=createnode(value);
    if(*head==NULL){
        *head=newnode;
        return;
    }
    struct node *temp=*head;
    while(temp->next!=NULL)
        temp=temp->next;
    temp->next=newnode;
}

// ---------------- Insert at given position (1-indexed) ----------------
// walks to the node just before the target position, then links
// the new node in between it and the node that follows
void insert(struct node **head, int value, int position){
    if(position==1){
        push_front(head, value);
        return;
    }
    if(*head==NULL){
        printf("Out Of Bound!\n");
        return;
    }

    struct node *newnode=createnode(value);
    struct node *temp=*head;
    int count=1;
    while(count<position-1 && temp!=NULL){
        temp=temp->next;
        count++;
    }
    if(temp==NULL){
        printf("Out Of Bound!\n");
        free(newnode);
        return;
    }
    newnode->next=temp->next;
    temp->next=newnode;
}

// ---------------- Delete from front ----------------
// moves head to the second node and frees the old first node
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
// walks to the second-to-last node, frees the last node,
// and marks the second-to-last node as the new end of the list;
// handles the single-node case separately
void pop_back(struct node **head){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }
    if((*head)->next==NULL){
        free(*head);
        *head=NULL;
        return;
    }
    struct node *temp=*head;
    while(temp->next->next!=NULL)
        temp=temp->next;
    free(temp->next);
    temp->next=NULL;
}

// ---------------- Delete at given position (1-indexed) ----------------
// walks to the node just before the target, unlinks the target node
// from the chain, and frees it
void delete(struct node **head, int position){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }
    if(position==1){
        pop_front(head);
        return;
    }

    struct node *temp=*head;
    int count=1;
    while(count<position-1 && temp->next!=NULL){
        temp=temp->next;
        count++;
    }
    if(temp->next==NULL){
        printf("Out of Bounds!\n");
        return;
    }
    struct node *toDelete=temp->next;
    temp->next=toDelete->next;
    free(toDelete);
}

// ---------------- Search for a value (returns position, 1-indexed) ----------------
// walks the list comparing each node's data to the target value;
// returns the 1-indexed position if found, or -1 if not found
int search(struct node *head, int value){
    struct node *temp=head;
    int position=1;
    while(temp!=NULL){
        if(temp->data==value)
            return position;
        temp=temp->next;
        position++;
    }
    return -1;
}

// ---------------- Sort the list (ascending, bubble sort on data) ----------------
// compares every pair of nodes and swaps their DATA (not the nodes
// themselves) whenever they're out of order
void sort(struct node *head){
    if(head==NULL) return;
    struct node *i, *j;
    for(i=head; i->next!=NULL; i=i->next){
        for(j=i->next; j!=NULL; j=j->next){
            if(i->data > j->data){
                int temp=i->data;
                i->data=j->data;
                j->data=temp;
            }
        }
    }
}

// ---------------- Print the list ----------------
// walks the list from head to end, printing each node's data
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
    struct node *head=NULL;

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

    delete(&head, 2);
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
