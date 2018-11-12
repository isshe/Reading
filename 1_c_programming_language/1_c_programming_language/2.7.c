#include <stdio.h>

int main(void)
{
	int c = 0;

	while ((c = getchar()) != EOF)
	{
		if (c >= 'A' && c <= 'Z')
		{
			c = c + 32;//'a' - 'A';
			putchar(c);
		}
		else
		{
			putchar(c);
		}
	}

	return 0;
}
