#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
  int data;
  int height;
  struct Node *left;
  struct Node *right;
} Node;

typedef struct SumCount {
  int sum;
  int count;
} SumCount;

int height(Node *node) {
  if (node)
    return node->height;
  return 0;
}

int max(int a, int b) { return (a > b) ? a : b; }

Node *rotate_right(Node *y) {
  Node *x = y->left, *t = x->right;

  x->right = y;
  y->left = t;

  y->height = max(height(y->left), height(y->right)) + 1;
  x->height = max(height(x->left), height(x->right)) + 1;

  return x;
}

Node *rotate_left(Node *x) {
  Node *y = x->right, *t = y->left;

  y->left = x;
  x->right = t;

  x->height = max(height(x->left), height(x->right)) + 1;
  y->height = max(height(y->left), height(y->right)) + 1;

  return y;
}

int get_balance(Node *node) {
  if (node)
    return height(node->left) - height(node->right);
  return 0;
}

Node *maximal_node(Node *node) {
  Node *current = node;

  while (current->right)
    current = current->right;

  return current;
}

Node *minimal_node(Node *node) {
  Node *current = node;

  while (current->left)
    current = current->left;

  return current;
}

Node *insert_node(Node *root, int data) {
  if (!root) {
    Node *new_node = malloc(sizeof(Node));
    *new_node = (Node){data, 1, NULL, NULL};

    return new_node;
  }

  if (data < root->data)
    root->left = insert_node(root->left, data);
  else if (data > root->data)
    root->right = insert_node(root->right, data);
  else
    return root;

  root->height = 1 + max(height(root->left), height(root->right));

  int balance = get_balance(root);

  if (balance > 1) {
    if (data < root->left->data)
      return rotate_right(root);
    else if (data > root->left->data) {
      root->left = rotate_left(root->left);
      return rotate_right(root);
    }
  } else if (balance < -1) {
    if (data > root->right->data)
      return rotate_left(root);
    else if (data < root->right->data) {
      root->right = rotate_right(root->right);
      return rotate_left(root);
    }
  }

  return root;
}

Node *delete_node(Node *root, int data) {
  if (!root)
    return root;

  if (data < root->data)
    root->left = delete_node(root->left, data);
  else if (data > root->data)
    root->right = delete_node(root->right, data);
  else if (root->left && root->right) {
    Node *temp = minimal_node(root->right);
    root->data = temp->data;
    root->right = delete_node(root->right, temp->data);
  } else {
    Node *temp = root->left ? root->left : root->right;

    if (temp)
      *root = *temp;
    else {
      temp = root;
      root = NULL;
    }
    free(temp);
  }

  if (!root)
    return root;

  root->height = 1 + max(height(root->left), height(root->right));

  int balance = get_balance(root);
  if (balance > 1 && get_balance(root->left) >= 0)
    return rotate_right(root);

  if (balance > 1 && get_balance(root->left) < 0) {
    root->left = rotate_left(root->left);
    return rotate_right(root);
  }

  if (balance < -1 && get_balance(root->right) <= 0)
    return rotate_left(root);

  if (balance < -1 && get_balance(root->right) > 0) {
    root->right = rotate_right(root->right);
    return rotate_left(root);
  }

  return root;
}

int min_tree_value(Node *root) { return minimal_node(root)->data; }
int max_tree_value(Node *root) { return maximal_node(root)->data; }

void sum_count_tree(Node *root, SumCount *sn) {
  sn->sum += root->data;
  sn->count += 1;

  if (root->left)
    sum_count_tree(root->left, sn);

  if (root->right)
    sum_count_tree(root->right, sn);
}

double average_tree_value(Node *root) {
  if (root) {
    SumCount sn = {0, 0};

    sum_count_tree(root, &sn);

    return (double)sn.sum / sn.count;
  } else
    return (double)0;
}

void free_node(Node *node) {
  if (node) {
    if (node->left)
      free_node(node->left);
    if (node->right)
      free_node(node->right);

    printf("%d... ", node->data);
    free(node);
  } else
    printf("can't free null!");
}

void free_tree(Node *root) {
  printf("freeing ");
  free_node(root);
  printf("done!\n");
}

void print_tree(Node *root, char *label) {
  if (root) {
    printf("%s", label);
    printf("%d (height %d)\n", root->data, root->height);
    char left_label[10];
    char right_label[10];
    sprintf(left_label, "%d / ", root->data);
    sprintf(right_label, "%d \\ ", root->data);
    print_tree(root->left, left_label);
    print_tree(root->right, right_label);
  }
}

int main() {
  struct Node *root = NULL;

  int items[] = {2, 1, 4, 3, 20, -3, 93, 91};

  for (int i = 0; i < sizeof(items) / sizeof(*items); i++)
    root = insert_node(root, items[i]);

  printf("tree:\n");
  print_tree(root, "");
  printf("\naverage tree value = %f\n", average_tree_value(root));

  root = delete_node(root, 3);

  printf("\ndeleted 3:\n");
  print_tree(root, "");
  printf("\naverage tree value = %f\n\n", average_tree_value(root));

  root = delete_node(root, 2);

  printf("deleted 2: \n");
  print_tree(root, "");
  printf("\nmin tree value = %d\n", min_tree_value(root));
  printf("max tree value = %d\n", max_tree_value(root));
  printf("average tree value = %f\n\n", average_tree_value(root));

  free_tree(root);

  return 0;
}
