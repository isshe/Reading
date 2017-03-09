/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : replaceSpace.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/25
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

class Solution {
public:
	void replaceSpace(char *str,int length) {
        int 	space_num = 0;
        char 	*temp_str;
        int 	i = 0;
        int 	temp_i = 0;
        int 	len = length;
        
        
        for (i = 0; i < len; i++)
    	{
        	if (str[i] == ' ')
        	{
            	space_num++;
        	}
    	}

//        temp_str = (char *)malloc(space_num + len);
 //   	temp_str = new char[space_num + len];
//    	cout << "space num =" << space_num<< endl;

    	for (i = len - 1, temp_i = len + space_num*2 - 1; i >= 0; i--, temp_i--)
    	{
        	if (str[i] == ' ')
        	{            	
                str[temp_i--] = '0';
            	str[temp_i--] = '2';
            	str[temp_i] = '%';

        	}
        	else
        	{
            	str[temp_i] = str[i];
        	}
    	}
        
//        str = temp_str;
        

	}
};

