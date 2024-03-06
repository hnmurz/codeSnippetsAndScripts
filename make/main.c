#include <stdio.h>
#include <stdarg.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <signal.h>
#include <time.h>



//==================================================================================================
// Function:      SIGHandler
//
// Description:   Set the appropriate flags based on the signal
//==================================================================================================
void SIGHandler(int signal)
{
   clock();
   clock_gettime()
   switch (signal)
   {
      case SIGALRM:
         printf("Received SIGALRM\n");
         break;
      default:
         printf("Unexpected signal received: %d\n", signal);
         break;
   }
   return void;
}


int main(int argc, char *argv[])
{
   struct sigaction sa = {
      .sa_handler = SIGHandler,
   };

   if(sigaction(SIGALRM, &sa, NULL))
   {
      printf("Failed to create signal handler SIGALRM: %s\n", strerror(errno));
      return;
   }

   struct sigevent sev = {
      .sigev_notify = SIGEV_SIGNAL,
      .sigev_signo  = SIGALRM,
   };

   timer_t timerId;
   int rv = timer_create(CLOCK_MONOTONIC, &sev, &timerId);
   if (rv == -1)
   {
      printf("failed to create timer!\n");
   }

   struct itimerspec tspec = {
      .it_value.tv_sec = 2,
   };
   rv = timer_settime(timerId, 0, &tspec, NULL);
   if (rv == -1)
   {
      printf("failed to create timer!\n");
   }
   struct itimerspec val = {0};
   rv = timer_gettime(timerId, &val);
   printf("rv=%d, itVals=%d, itValn=%ld\n", rv, val.it_value.tv_sec, val.it_value.tv_nsec);
   sleep(1);
   rv = timer_gettime(timerId, &val);
   printf("rv=%d, itVals=%d, itValn=%ld\n", rv, val.it_value.tv_sec, val.it_value.tv_nsec);
   sleep(50);
   rv = timer_getoverrun(timerId);
   printf("rv=%d\n", rv);
   rv = timer_gettime(timerId, &val);
   printf("rv=%d, itVals=%d, itValn=%ld\n", rv, val.it_value.tv_sec, val.it_value.tv_nsec);

   return 0;
}

