#include <stdlib.h>
#include <stdio.h>

#define PRINT_SEQ(_seq, size, iteration)                       \
   printf("i=%4d: ", iteration);                               \
   for (int _i = 0; _i < size; _i++) printf("%d ", _seq[_i]);  \
   printf("\n");


#define SWAP(x,y)                               \
   {                                            \
      int temp = x;                             \
      x = y;                                    \
      y = temp;                                 \
   }

// Yay bubble sort!!
void sort(int *seq, int size)
{
   int i = size;
   for (int i = 0; i < size; i++) {
      for (int j = 0; j < (size - 1); j++) {
         if (seq[j] > seq[j+1]) {
            SWAP(seq[j], seq[j+1]);
         }
      }
   }
   printf("Sorted: "); for (int i = 0; i < size; i++) printf("%d ", seq[i]); printf("\n");
   return;
}

// Permutation via backtracking
void permutations(int *seq, int *count, int l, int h)
{
   // Base case
   // Add the vector to result and return
   if (l == h) {
      PRINT_SEQ(seq, (h+1), (*count));
      (*count)++;
      return;
   }

   // Permutations made
   for (int i = l; i <= h; i++) {
      SWAP(seq[l], seq[i]); // swap
      permutations(seq, count, l + 1, h);
      SWAP(seq[l], seq[i]); // backtrack
   }
   return;
}

int main(int argc, char *argv[])
{
   int seq[] = {0, 4, 5};
   int count = 0;
   sort(seq, sizeof(seq)/sizeof(int));
   permutations(seq, &count, 0, (sizeof(seq)/sizeof(int) - 1));
   return 0;
}
