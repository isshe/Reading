#include <stdio.h>

int main(void)
{
	int i = 0;
	int j = 0;
	int c = 0;
	int flag = 0;
	int array[10] = {0};
	int count = 0;

	while ((c = getchar()) != EOF)
	{
		if ((c == ' ') || (c == '\t') || (c == '\n') || (c == '.') || (c == ',') || (c == '!'))
		{
			if (flag == 1)
			{
				array[count]++;
				count = 0;
			}	
			
			flag = 0;
			continue;
		}
		else if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
		{
			count ++;
			flag = 1;
		}
   	}

	/*处理最后一个单词*/
	array[count]++;

	for (i = 15; i > 0; i--)
	{
		printf("%2.0d|", i);

		for (j = 0; j < 10; j++)
		{
			if (array[j] >= i)
			{
				printf("* ");
			}
			else
			{
				printf("  ");
			}
		}

		printf("\n");
	}

	printf("---------------------------\n");
	printf("    ");

	for (i = 1; i< 11; i++)
	{
		printf(" %d", i);
	}
	return 0;
}
