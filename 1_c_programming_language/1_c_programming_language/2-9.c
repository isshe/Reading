#include <stdio.h>

int main(void)
{
	int x = 0;
	int count = 0;

	printf("please enter a number:\n");
	scanf("%d", &x);

	for (; x != 0; x &= (x-1))
	{
		count++;
	}

	printf("count = %d\n", count);

	return 0;
}
