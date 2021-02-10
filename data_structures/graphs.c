#include <stdio.h>
#include <stdlib.h>

struct Node;

typedef struct Adjacency {
  struct Node *head;
  struct Adjacency *next;
} Adjacency;

typedef struct Node {
  int id;
  Adjacency *adjacencies;
} Node;

typedef struct Graph {
  int size;
  Node **node_ptrs;
} Graph;

typedef struct Edge {
  Node *tail;
  Node *head;
} Edge;

typedef struct Stack {
  Edge *edge;
  struct Stack *tail;
} Stack;

Stack *new_stack(Edge *item) {
  Stack *stack = malloc(sizeof(Stack));
  *stack = (Stack){item, NULL};
  return stack;
}

int is_stack_empty(Stack *stack) { return !stack; }

Edge *pop_from_stack(Stack **stack) {
  Edge *edge = (*stack)->edge;
  free(*stack);
  *stack = (*stack)->tail;
  return edge;
}

void push_to_stack(Stack **stack, Edge *edge) {
  Stack *new_stack = malloc(sizeof(Stack));
  *new_stack = (Stack){edge, *stack};
  *stack = new_stack;
}

Graph *new_graph(int size) {
  Graph *graph = malloc(sizeof(Graph));
  graph->size = size;
  graph->node_ptrs = malloc(sizeof(Node *) * size);
  return graph;
}

void insert_node(Graph *graph, int id) {
  Node *new_node = malloc(sizeof(Node));
  *new_node = (Node){id, NULL};
  graph->node_ptrs[id] = new_node;
}

void insert_adjacency(Graph *graph, int tail_id, int head_id) {
  Adjacency *adjacency = malloc(sizeof(Adjacency));
  *adjacency = (Adjacency){graph->node_ptrs[head_id],
                           graph->node_ptrs[tail_id]->adjacencies};
  graph->node_ptrs[tail_id]->adjacencies = adjacency;
}

void connect_nodes(Graph *graph, int first_id, int second_id) {
  insert_adjacency(graph, first_id, second_id);
  insert_adjacency(graph, second_id, first_id);
}

void print_graph(Graph *graph) {
  for (int i = 0; i < graph->size; i++) {
    Node *current = graph->node_ptrs[i];

    printf("%d: ", current->id);

    if (!current->adjacencies)
      printf("dangling\n");
    else {
      Adjacency *current_adjacency = current->adjacencies;
      while (current_adjacency) {
        printf("^%d, ", current_adjacency->head->id);
        current_adjacency = current_adjacency->next;
      }
      printf("\n");
    }
  }
}

int is_id_in_graph(Graph *graph, int id) { return !!graph->node_ptrs[id]; }

Graph *get_spanning_tree(Graph *graph) {
  Graph *tree_graph = new_graph(graph->size);

  for (int i = 0; i < graph->size; i++)
    tree_graph->node_ptrs[i] = NULL;

  Edge *root_edge = malloc(sizeof(Edge));
  *root_edge = (Edge){NULL, graph->node_ptrs[0]};
  Stack *stack = new_stack(root_edge);

  while (!is_stack_empty(stack)) {
    Edge *current_edge = pop_from_stack(&stack);
    if (!is_id_in_graph(tree_graph, current_edge->head->id)) {
      insert_node(tree_graph, current_edge->head->id);
      if (current_edge->tail)
        connect_nodes(tree_graph, current_edge->tail->id,
                      current_edge->head->id);

      Adjacency *current_adjacency = current_edge->head->adjacencies;

      while (current_adjacency) {
        if (!is_id_in_graph(tree_graph, current_adjacency->head->id)) {
          Edge *edge = malloc(sizeof(Edge));
          *edge = (Edge){current_edge->head, current_adjacency->head};
          push_to_stack(&stack, edge);
        }
        current_adjacency = current_adjacency->next;
      }
    }
    free(current_edge);
  }

  return tree_graph;
}

Graph *import_graph(char filename[]) {
  int n;

  FILE *file = fopen(filename, "r");

  if (file) {
    fscanf(file, "%d", &n);

    Graph *graph = new_graph(n);

    for (int i = 0; i < graph->size; i++)
      insert_node(graph, i);

    for (int row = 0; row < graph->size; row++) {
      for (int col = 0; col < graph->size; col++) {
        fscanf(file, "%d", &n);
        if (n > 0)
          insert_adjacency(graph, row, col);
      }
    }

    fclose(file);

    return graph;
  } else {
    printf("%s does not exist\n", filename);

    return NULL;
  }
}

void free_node(Node *node) {
  Adjacency *current_adjacency = node->adjacencies;
  Adjacency *tmp;

  while (current_adjacency) {
    tmp = current_adjacency;
    current_adjacency = current_adjacency->next;
    free(tmp);
  }

  free(node);
}

void free_graph(Graph *graph) {
  for (int i = 0; i < graph->size; i++)
    if (graph->node_ptrs[i])
      free_node(graph->node_ptrs[i]);

  free(graph->node_ptrs);
  free(graph);
}

int main() {
  char filename[] = "adjacency_matrix.txt";
  Graph *graph = import_graph(filename);

  if (graph) {
    printf("graph:\n");
    print_graph(graph);

    Graph *spanning_tree = get_spanning_tree(graph);

    printf("\nspanning tree from %d:\n", spanning_tree->node_ptrs[0]->id);
    print_graph(spanning_tree);

    free_graph(graph);
    free_graph(spanning_tree);
  }

  return 0;
}
