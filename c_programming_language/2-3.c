//功能:十六进制转换为十进制

#include <stdio.h>
#include <math.h>
#include <string.h>

#define HEX 16

void my_htoi(char *s);

int main(void)
{
	int c; 
	char array[100];
	int i = 0;

	printf("请输入十六进制数:\n");
	while((c = getchar()) != '\n')
	{
		array[i] = c;
		i++;
	}

	array[i] = '\0';

	my_htoi(array);
	
	return 0;
}

void my_htoi(char *s)
{
	int i = 0;
	int j = 0;
	int answer = 0;

	if ((s[0] == '0' && s[1] == 'x') || (s[0] == '0' && s[1] == 'X'))
	{
		i = strlen(s) - 2;
		printf("strlen = %d\n", i);
		j = 2;
	}
	else
	{
		i = strlen(s);
		printf("strlen = %d\n", i);
		j = 0;
	}

	for (; i > 0; i--, j++)
	{
		answer = answer + (s[j] - '0') * pow((double)HEX, (double)i-1);
	}

    printf("转换为十进制%d\n", answer);

}

