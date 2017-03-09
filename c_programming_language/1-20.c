#include <stdio.h>

void detab()
{
	printf("    ");
};

int main(void)
{
	int c = 0;

	while((c = getchar()) != EOF)
	{
		if (c == '\t')
		{
			detab();
		}
		else
		{
			putchar(c);
		}
	}

	return 0;
}
