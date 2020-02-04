#include <stdio.h>

void select_sort(int a[], int n)
{
  int i, j, k;
  for (i = 0; i < n - 1; i++)
  {
    k = i;
    for (j = i + 1; j < n; j++)
      if (a[j] < a[k])
        k = j;
    j = a[k];
    a[k] = a[i];
    a[i] = j;
  }
}

int main() {
  int array[5] = {7, 5, 9, 4, 6};

  enum students {Aalov, Balov=0, Valov=5, Galov, Dalov};
  enum students Students=Dalov;
  printf("%d%d%d%d\n",Students,Balov,Galov,Dalov);

  //

  list *Current=Head;
  Current=Current->next;
  for (i=1; i<Number&&Current->next!=NULL; i++)
  if (Current->next!=NULL)
  if (Head!=NULL)
  Current->next=NewItem;
  list * NewItem=(list*)malloc(sizeof(list));
  NewItem->next=NULL;
  NewItem->inf=DataItem;
  Number--;
  if (Number!=0)
  NewItem->next=Current->next;

  return 0;
}
