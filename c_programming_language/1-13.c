#include <stdio.h>

int main(void)
{
	int array[10] = {0};
	int i = 0;
	int flag = 0;
	int c = 0;
	int count = 0;
	int j = 0;

	while ((c = getchar()) != EOF)
	{
		if ((c == ' ') || (c == '\t') || (c == '\n') || (c == ',') || (c == '.') || (c == '!'))
		{
			if( flag == 1)
			{
				array[count]++;
				count = 0;
			}
			flag = 0;
			continue;
		}
		else if ( (c <= 'z' && c >= 'a') || (c <= 'Z' && c >= 'A'))
		{
			count++;
			flag = 1;
		}
	}

	for (i = 0; i < 10; i++)
	{
		printf("%d|", i);
		
		j = array[i];
		
		for (; j > 0; j--)
		{
			printf("*");
		}

		printf("\n");
	}
	
	return 0;
}
