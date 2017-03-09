#include <stdio.h>

int main(void)
{
	int c = 0;
	int num_str = 0;
	int flag = 0;

	while((c = getchar()) != EOF)
	{
		if (c == ' ')
		{
			num_str++;
			flag == 0;
		}
		else 
		{
			if (flag == 0)
			{
				/*调用一个函数处理最少tab和space*/
				num_str = 0;
			}
			
			putchar(c);/*fjfdlfl*/
		}
	}
}
