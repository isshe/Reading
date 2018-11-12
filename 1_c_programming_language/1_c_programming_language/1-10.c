#include <stdio.h>

int main(void)
{
	int c = 0;

	while ((c = getchar()) != EOF)
	{
		switch(c)
		{
			case '\n' : printf("\\n");
						break;
			case ' '  : printf("\\b");
						break;
			case '\\'  : printf("\\\\");
						break;
			case '\t' : printf("\\t");
						break;
			default   : putchar(c);
						break;
		}
	}

	return 0;
}
