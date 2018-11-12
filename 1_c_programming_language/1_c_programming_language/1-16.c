#include <stdio.h>

#define MAXLINE 1024

int get_line(char line[], int maxline);
//void copy(char to[], char from[]);

int main(void)
{
	int len = 0;
	int max = 0;
	char line[MAXLINE] = {0};
//	char longest[MAXLINE] = {0};

	max = 0;
	while ((len = get_line(line, MAXLINE)) > 0)
	{
		printf("%s", line);
	}

	return 0;
}

int get_line(char s[], int lim)
{
	int c = 0;
	int i = 0;

	for (i = 0; (i < lim -1) && (c = getchar()) != EOF && (c != '\n'); i++)
	{
		s[i] = c;
	}

	if (c == '\n')
	{
		s[i] = c;
		i++;
	}
	s[i] = '\0';

	return i;
}
