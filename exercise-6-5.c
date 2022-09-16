// I am going to implement a hash table in this program

// Algorithm:
// 1. Generate a hash for the given word
// 2. In the internal array, place the string as a node at the hash position
// 3. If that index is non empty, add the new string to the end of that list
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define TABLE_SIZE 100003 // Nearest prime around 100k

struct h_list{
    struct h_list *next;
    char *key;
    char *value;
};

typedef struct h_list h_list;

h_list *hash_table[TABLE_SIZE] = {NULL};

h_list *h_list_create(const char *key, const char *value);
h_list *h_list_append(h_list *parent, const char *key, const char *value);
void h_list_free_single(h_list *hl); // Frees a single node
void h_list_free(h_list *root); // Frees the entire list starting from root

void table_store(const char *key, const char *value);
h_list *table_lookup(const char *key); // Look up the key in the table
void table_free(void); // Really inefficient, TODO: Create a slab/arena allocator
unsigned int hash(const char *s);

void *safe_malloc(size_t n); // A safer version of malloc which causes the program to exit if memory cannot be allocated
char *duplicatestr(const char *s); // Works like the strdup() function

char *duplicatestr(const char *s)
{
    char *buffer = safe_malloc(sizeof(char) * (strlen(s) + 1)); // +1 for the \0 character
    strcpy(buffer, s);
    return buffer;
}

void *safe_malloc(size_t n)
{
    void *ptr = malloc(n);
    if(!ptr)
    {
        printf("Memory allocation failed! Check if your PC ran out of memory\n");
        exit(2);
    }
    return ptr;
}

h_list *h_list_create(const char *key, const char *value)
{
    h_list *new_node = safe_malloc(sizeof(h_list));
    new_node->key = duplicatestr(key);
    new_node->value = duplicatestr(value);
    new_node->next = NULL;
    return new_node;
}
h_list *h_list_append(h_list *parent, const char *key, const char *value)
{
    if(parent)
    {
        // Go to the last node
        while(parent->next)
        {
            parent = parent->next;
        }
        parent->next = h_list_create(key, value);
        return parent->next;
    }
    else{
        return h_list_create(key, value);
    }
}
void h_list_free_single(h_list *hl)
{
    if(hl)
    {
        free(hl->key);
        free(hl->value);
        hl->key = NULL;
        hl->value = NULL;
        free(hl);
    }
}
void h_list_free(h_list *root)
{
    h_list *tmp;
    while(root)
    {
        tmp = root;
        root = root->next;
        h_list_free_single(tmp);
    }
}

void table_store(const char *key, const char *value)
{
    unsigned int hash_val = hash(key);
    h_list *ins_pos = hash_table[hash_val];
    if(!ins_pos)
    {
        hash_table[hash_val] = h_list_create(key, value);
    }
    else
    {
        h_list_append(hash_table[hash_val], key, value);
    }
}
h_list *table_lookup(const char *key)
{
    unsigned int hash_val = hash(key);
    h_list *node = hash_table[hash_val];
    while(node)
    {
        if(strcmp(key, node->key) == 0)
            return node;
        node = node->next;
    }
    return NULL;
}

unsigned int hash(const char *s)
{
    unsigned int hash_val = 5381;
    while(*s)
    {
        hash_val = hash_val*33 + *s;
        s++;
    }
    return hash_val % TABLE_SIZE;
}

void table_free(void)
{
    // Really inefficient :/ Use a slab allocator
    for(int i = 0; i < TABLE_SIZE; i++)
    {
        if(hash_table[i]) h_list_free(hash_table[i]);
    }
}

void find(const char *key)
{
    h_list *node = table_lookup(key);
    if(!node)
        printf("%-12s : %s\n", key, "Key Error: Such a key does not exist");
    else
        printf("%-12s : %s\n", key, node->value);
}

int main()
{
    table_store("Hello", "world");
    table_store("this", "is");
    table_store("the", "quick");
    table_store("brown", "fox");
    table_store("Hello earth", "This string is about the great planet called earth");

    find("Hello");
    find("brown");
    find("the");
    find("this");
    find("This does not");
    find("Hello earth");
    find("BA BA BA");
    table_free();
}
