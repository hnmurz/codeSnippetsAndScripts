#include <stdio.h>
#include <getopt.h>

#define ARG_STR "f:b:h"
static struct option options[] = {
   {
      .name    = "help",
      .val     = 'h',
   },
   {
      .name    = "foo",
      .has_arg = 1,
      .val     = 'f',
   },
   {
      .name    = "bar",
      .has_arg = 1,
      .val     = 'b',
   },
};
#define HELP_STR "\noptargs.c\n\
 An example on how to use optargs.\n\
Usage: a.out [OPTIONS]\n\n\
Options:\n\
-f, --foo     Doesn't mean anything\n\
-b, --bar     Also doesn't mean anything\n\
"
int main(int argc, char** argv)
{
   int option;
   int foo = 0;
   int bar = 0;
   option = getopt_long(argc, argv, ARG_STR, options, NULL);
   while (option != -1)
   {
      switch (option)
      {
      case 'f':
         sscanf(optarg, "%d", &foo);
         break;
      case 'b':
         sscanf(optarg, "%d", &bar);
         break;
      case 'h':
      default:
         printf(HELP_STR);
         return 1;
      }
      option = getopt_long(argc, argv, ARG_STR, options, NULL);
   }

   printf("foo=%d, bar=%d\n", foo, bar);
   return 0;
}
