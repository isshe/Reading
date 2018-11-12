/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : printListFromTailToHead_2.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/25
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/


void printListFromTailToHead_2(int *pHead)
{
    if (pHead == NULL)
    {
        return ;
    }

    if (pHead->next != NULL)
    {
        printListFromTailToHead_2(pHead->next);
        printf("%d ", pHead->data);
    }
}
