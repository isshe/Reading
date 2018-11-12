#include <stdio.h>

int main(void)
{
	int c = 0;
	int i = 0;
	int j = 0;
	char sour_str[1024];
	char str[1024];

	fprintf(stdout, "请输入字符串:\n");
	fgets(sour_str, 1024, stdin);
	fprintf(stdout, "请输入要查找的字符集:\n");
	fgets(str, 1024, stdin);

	for (i = 0; sour_str[i] != '\0'; i++)
	{
		for (j = 0; str[j] != '\0'; j++)
		{
			if (str[j] == sour_str[i])
			{
				printf("在第%d个字符找到%c!\n", i+1, sour_str[i]);
				return 0;
			}
		}
	}

	printf("-1");
	return 0;
}
