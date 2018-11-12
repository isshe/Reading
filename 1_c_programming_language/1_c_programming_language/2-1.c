#include <stdio.h>
#include <limits.h>
int
main ()
{
    printf("Sizeof Char %d\n", CHAR_BIT);
    printf("Sizeof Char Max %d\n", CHAR_MAX);
    printf("Sizeof Char Min %d\n", CHAR_MIN);
    printf("Sizeof int min %d\n", INT_MIN);
    printf("Sizeof int max %d\n", INT_MAX);
    printf("Sizeof long min %ld\n", LONG_MIN);
    printf("Sizeof long max %ld\n", LONG_MAX);
    printf("Sizeof short min %d\n", SHRT_MIN);/* RB */
    printf("Sizeof short max %d\n", SHRT_MAX);/* RB */
    printf("Sizeof unsigned char %u\n", UCHAR_MAX); /* SF */
    printf("Sizeof unsigned long %lu\n", ULONG_MAX); /* RB */
    printf("Sizeof unsigned int %u\n", UINT_MAX); /* RB */
    printf("Sizeof unsigned short %u\n", USHRT_MAX); /* SF */
    
    printf("sizeof(char) = %d\n", sizeof(char));
    
    printf("sizeof(int)=%d\n", sizeof(int));   
    printf("sizeof(short int) = %d\n", sizeof(short int));   
    printf("sizeof(long int) = %d\n", sizeof(long int));
    printf("sizeof(long long int) = %d\n", sizeof(long long int));
    
    printf("sizeof(float)= %d\n", sizeof(float));
    printf("sizeof(double) = %d\n", sizeof(double));
    return 0;
}












