#include <stdio.h>
#include <stdlib.h>

struct node {
    int v;
    struct node *next;
};
typedef struct node node_t;

void print(node_t *head)
{
    size_t pos = 0;
    for (node_t *it = head; it != NULL; it = it->next, ++pos)
        printf("addr:%p pos:%zu v:%d\n", it, pos, it->v);
}

// 22.49
int main(int argc, char **argv)
{
    (void)argc, (void)argv;

    node_t *head = (node_t *)calloc(1, sizeof(node_t));
    {
        node_t *it = head;
        for (size_t i = 1; i < 10; ++i)
        {
            it->next = (node_t *)calloc(1, sizeof(node_t));
            it->next->v = i;
            it = it->next;
        }
    }

    printf("Origin:\n");
    print(head);

    node_t* it = head, *next = NULL;
    head = NULL;

    for (;it != NULL; it = next)
    {
        next = it->next;
        it->next = head;
        head = it;
        it = next;
    }

    printf("Reverted:\n");
    print(head);

    return 0;
}
