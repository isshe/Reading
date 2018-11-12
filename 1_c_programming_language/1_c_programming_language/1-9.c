#include <stdio.h>

int main(void)
{
	int c = 0;
	int flag = 0;

	while ((c = getchar()) != EOF)
	{
		if ( c != ' ')
		{
			putchar(c);
			flag = 0;
		}
		else
		{
			if (flag == 1)
			{
				continue;
			}
			else
			{
				putchar(c);
				flag = 1;
			}
		}
	}
	
	return 0;
}
