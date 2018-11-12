#include <ctype.h>
#include <stdio.h>

/* atof: convert string s to double */
double atof(char s[])
{
    double val, power;
    int i, sign;
    printf("s = %s\n", s);
    for (i = 0; isspace(s[i]); i++) /* skip white space */
        ;
    sign = (s[i] == '-') ? -1 : 1;
    if (s[i] == '+' || s[i] == '-')
        i++;
    for (val = 0.0; isalpha(s[i]); i++)
        val = 10.0 * val + (s[i] - '0');
    if (s[i] == '.')
        i++;
    for (power = 1.0; isdigit(s[i]); i++)
    {
        val = 10.0 * val + (s[i] - '0');
        power *= 10;
    }
    return sign * val / power;
}


int main(void)
{
    char s[100];
    double num = 0;
    
    printf("请输入字符串:\n");
    scanf("%s", s);
//    fgets(s, 100, stdin);
    printf("输入的字符串为:%s\n", s);
    num = atof(s);
    
    printf("num = %lf\n", num);
    
}
