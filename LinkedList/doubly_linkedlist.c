#include<stdio.h>
#include<stdlib.h>

// A node in a doubly linked list.
// Unlike a singly linked list, each node here holds TWO links:
// - next: pointer to the following node
// - prev: pointer to the preceding node
// This lets you walk the list in either direction.
struct node{
    int data;
    struct node *next;
    struct node *prev;
};

// Allocates a new node on the heap, fills in its data,
// and initializes both next and prev to NULL (it starts "detached"
// from any list — whoever inserts it decides how to link it in).
struct node *createnode(int value){
    struct node *newnode=(struct node*)malloc(sizeof(struct node));
    if(newnode==NULL){                     // always check malloc didn't fail
        printf("Memory allocation failed!\n");
        exit(1);
    }
    newnode->data=value;
    newnode->next=NULL;
    newnode->prev=NULL;
    return newnode;
}

// Inserts a new node before the current head, making it the new head.
// head is struct node** because this function must change what the
// CALLER's head variable points to — a plain struct node* would only
// get a local copy, and main's head would never actually update.
void push_front(struct node **head, int value){
    struct node *newnode=createnode(value);

    newnode->next=*head;      // new node points forward to the old head

    if(*head!=NULL)            // only if the list wasn't empty...
        (*head)->prev=newnode; // ...old head must point BACKWARD to the new node

    *head=newnode;              // finally, head itself now points to the new node
}

// Inserts a new node after the current last node.
// If the list is empty, the new node simply becomes the head (and the
// only node) — no walking or linking needed in that case.
void push_back(struct node **head, int value){
    struct node *newnode=createnode(value);

    if(*head==NULL){            // empty list special case
        *head=newnode;
        return;
    }

    struct node *temp=*head;
    while(temp->next!=NULL){    // walk until temp is the LAST node
        temp=temp->next;
    }

    temp->next=newnode;         // old last node now points forward to new node
    newnode->prev=temp;         // new node points backward to old last node
}

// Inserts a new node at a given 1-indexed position.
// position == 1 is handled separately by reusing push_front, since
// walking with a "previous node" pointer doesn't work for the very front
// (there's no node before the head to walk from).
void insert(struct node **head, int value, int position){
    if(position==1){
        push_front(head,value);
        return;
    }
    if(*head==NULL){             // can't insert at position > 1 in an empty list
        printf("Out of bound!\n");
        return;
    }

    struct node *newnode=createnode(value);
    struct node *temp=*head;
    int count=1;

    // walk temp to the node JUST BEFORE the target position
    while(count<position-1 && temp!=NULL){
        temp=temp->next;
        count++;
    }

    if(temp==NULL){               // position was beyond the end of the list
        printf("Out of bound!\n");
        return;
    }

    // splice newnode in between temp and temp->next
    newnode->next=temp->next;
    newnode->prev=temp;

    if(temp->next!=NULL)          // if temp wasn't the last node...
        temp->next->prev=newnode; // ...that next node must point back to newnode

    temp->next=newnode;
}

// Removes the first node of the list.
void pop_front(struct node **head){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }

    struct node *temp=*head;      // save the node we're about to remove
    *head=temp->next;             // head now points to the second node

    if(*head!=NULL)               // if a new head exists...
        (*head)->prev=NULL;       // ...it has nothing before it anymore

    free(temp);                   // release the removed node's memory
}

// Removes the last node of the list.
// Handles the single-node case separately, since in that case there's
// no "second-to-last" node to walk to.
void pop_back(struct node **head){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }

    if((*head)->next==NULL){      // only one node in the list
        free(*head);
        *head=NULL;
        return;
    }

    struct node *temp=*head;
    // walk until temp->next IS the last node (i.e. temp is SECOND-to-last)
    while(temp->next->next!=NULL)
        temp=temp->next;

    free(temp->next);             // free the actual last node
    temp->next=NULL;               // temp is now the new last node
}

// Deletes the node at a given 1-indexed position.
// position == 1 is handled separately by reusing pop_front, for the
// same reason insert() special-cases it.
void delete(struct node **head,int position){
    if(*head==NULL){
        printf("List is empty!\n");
        return;
    }
    if(position==1){
        pop_front(head);
        return;
    }

    int count=1;
    struct node *temp=*head;

    // walk temp to the node JUST BEFORE the one to delete
    while(count<position-1 && temp->next!=NULL){
        temp=temp->next;
        count++;
    }

    if(temp->next==NULL){          // the node to delete doesn't exist
        printf("Out of Bounds!\n");
        return;
    }

    struct node *remove=temp->next;   // the node being deleted
    temp->next=remove->next;          // skip over it going forward

    if(remove->next!=NULL)            // if it wasn't the last node...
        remove->next->prev=temp;      // ...skip over it going backward too

    free(remove);
}

// Prints the list from head to the last node, using next pointers.
// Takes a single pointer (struct node*, not **) because this function
// only READS the list — it never needs to change what the caller's
// head variable points to.
void traverse(struct node *head){
    if(head==NULL){
        printf("List is Empty!\n");
        return;
    }

    struct node *temp=head;
    while(temp!=NULL){             // stop only when truly past the last node
        printf("%d ",temp->data);
        temp=temp->next;
    }
    printf("\n");
}

int main(){
    struct node *head=NULL;        // always initialize head to NULL — an
                                    // uninitialized pointer holds garbage

    push_back(&head, 10);
    push_back(&head, 20);
    push_back(&head, 30);
    traverse(head);              // 10 20 30

    push_front(&head, 5);
    traverse(head);              // 5 10 20 30

    insert(&head, 99, 3);
    traverse(head);              // 5 10 99 20 30

    pop_front(&head);
    traverse(head);              // 10 99 20 30

    pop_back(&head);
    traverse(head);              // 10 99 20

    delete(&head, 2);
    traverse(head);              // 10 20

    pop_back(&head);
    pop_back(&head);
    traverse(head);              // List is Empty!

    pop_back(&head);             // should print message, not crash
    pop_front(&head);            // should print message, not crash

    return 0;
}
