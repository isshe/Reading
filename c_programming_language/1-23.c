#include <stdio.h>

int main(void)
{
	int c = 0;
	int d = 0;
	int flag = 0;

	flag = 1;

	while ((c = getchar()) != EOF)
	{
		if (c == '/')
		{
			
			d = getchar();			/**/
			
			if (d == '*')			/*   */
			{
				flag = 0;
			}
		}

		if (flag == 1)
		{
			/*dsafdsfsdj*/
			putchar(c);
		}
		else
		{
			if ((c == '*') && ((d = getchar()) == '/'))
			{
				flag = 1;
			}
		}
	}

	return 0;
}

