#include <stdio.h>
#include <ctype.h>
int main(void)
{
	char c = 0;
	c = getchar();

	if (isalnum(c))
	{
		printf("c = %c\n", c);
	}
	else
	{
		printf("c");
	}

	return 0;
}
