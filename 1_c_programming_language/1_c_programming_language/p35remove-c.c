#include <stdio.h>

int main(void)
{
	int c = 0;
	int i = 0;
	int j = 0;
	char s[100] = {0};
	
	printf("请输入字符串:\n");
	fgets(s, 100, stdin);
	printf("请输入要去除的字符:\n");
	c = getchar();
	
	for (i = 0, j = 0; s[i] != '\0'; i++)
	{
		if (s[i] != c)
		{
			s[j] = s[i];
			j++;
		}
	}

	s[j] = '\0';
	fputs(s, stdout);
	
	return 0;
}
