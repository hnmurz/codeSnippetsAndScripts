#include <inttypes.h>
#include <stdio.h>

//gcc printfFormatSpecifiers.c

int main(int argc, char **argv)
{
   uint64_t test = 2341234;
   printf("%" PRIu64 "\n", test);
   // Print uin64 as hex
   printf("%" PRIx64 "\n", test);
   // Print uin64 as hex with 0x
   printf("%#" PRIx64 "\n", test);
   printf("%#.16" PRIx64 "\n", test);

   // Printing variable number of chars
   printf("%.5s\n", "===========");
   printf("%.*s\n", 4, "===========");

   // Automatically prepend 0x
   printf("%#X\n", test);
   printf("%#x\n", test);
   printf("%#.3x\n", test);
   printf("%#.8X\n", test);

   // Using an integer as the width specifier
   // + is the default behaviour
   printf("%+*s\n", 20, "test");
   printf("%+*s\n", 20, "Another test");
   printf("%-*s\n", 20, "test");
   printf("%-*s\n", 20, "Another test");

   return 0;
}
