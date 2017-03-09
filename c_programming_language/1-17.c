#include <stdio.h>

#define MAXLINE 1024

int main(void)
{
	int i = 0;
	int c = 0;
	char str[MAXLINE] = {0};

	while(1)
	{
		for (i = 0; (i < MAXLINE - 1) && (c = getchar()) != EOF && c != '\n'; i++)
		{
			str[i] = c;
		}

		if (c == '\n')
		{
			str[i] = c ;
			i++;
		}

		str[i] = '\0';
		
		if ( i >= 80 )
		{
			printf("%s", str);
		}
	}

}
