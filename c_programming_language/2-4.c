#include <stdio.h>

int main(void)
{
	int c = 0;
	char del_c[1024];
	char sour_str[1024];
	int i = 0;
	int k = 0;
	int j = 0;

	printf("请输入字符串:\n");
	fgets(sour_str, 1024, stdin);
	printf("请输入要删除的字符集合:\n");
	fgets(del_c, 1024, stdin);

	for (i = 0; del_c[i] != '\0'; i++)
	{
		c = del_c[i];

		for (j = 0, k = 0; sour_str[j] != '\0'; j++)
		{
			if (sour_str[j] != c)
			{
				sour_str[k] = sour_str[j];
				k++;
			}
		}
		sour_str[k] = '\0';
	}

	printf("目标字符串为:\n%s\n", sour_str);

	return 0;
}
