#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <sys/times.h>
#include <sys/types.h>
#include <sys/wait.h>

#define HZ 100

void cpuio_bound(int last, int cpu_time, int io_time);

int main(void)
{
    pid_t pid = fork();
    if ( pid < 0) {
        printf("fork error!\n");
    } else if( pid == 0) {
        cpuio_bound(10, 0, 2);
    } else {
        printf("I am parent, pid = %d\n", pid);
        int status;
        pid_t wpid = wait(&status);
        printf("after wait: status = %d, wpid = %d\n", status, wpid);
    }
    return 0;
}

void cpuio_bound(int last, int cpu_time, int io_time)
{
    struct tms start_time, current_time;
    clock_t utime, stime;
    int sleep_time;

    while(last > 0)
    {
        times(&start_time);

        do
        {
            times(&current_time);
            utime = current_time.tms_utime - start_time.tms_utime;
            stime = current_time.tms_stime - start_time.tms_stime;
        } while((utime + stime)/HZ < cpu_time);

        last -= cpu_time;

        if (last <= 0)
        {
            break;
        }

        // 模拟IO请求的耗时
        sleep_time = 0;
        while(sleep_time < io_time)
        {
            sleep(1);
            sleep_time++;
        }

        last -= sleep_time;
    }
}
