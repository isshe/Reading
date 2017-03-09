using namespace std;
#include <iostream>

int main(void)
{
    string str = "1234567";
    
    char temp = str[1];
    str[1] = str[2];
    str[2] = temp;
    
    cout << str << endl;
    
    return 0;
    
}
