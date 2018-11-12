/*****************
*答案在95页
*****************/


#include <stdio.h>

int main(void)
{
	int c = 0;
	int array[1024];
	int top = -1;
	
	while ((c = getchar()) != EOF)
	{
		if ((c == '{') || (c == '}') || (c == '[') || (c == ']') || (c = '(') || (c == ')'))
		{
			array[++top] = c;
			putchar(c);

			if (c == '}')
			{
				if (top != 0 && array[top-1] == '{')
				{
					array[top--] = 0;
					array[top--] = 0;
				}
				else
				{
					printf("{}不匹配!\n");
				}
			}
			else if ( c == ']')
			{
				if (top != 0 && array[top-1] == '[')
				{
					top -= 2;
				}
				else
				{
					printf("[]不匹配!\n");
				}
			}
			else if ( c == ')')
			{
				if (top != 0 && array[top-1] == '(')
				{
					top -= 2;
				}
				else
				{
					printf("()不匹配!\n");
				}
				}/*else if*/
		}/*if*/
	}/*while*/

	return 0;
}
