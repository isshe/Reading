using namespace std;
#include <iostream>
#include <vector>

class Solution {
public:
//    vector<int> copy;
    
    int InversePairs(vector<int> data) {
        int len = data.size();
        if (len == 0)
            return 0;
        int i = 0;
        
        int *copy = new int[len];
        int *temp = new int[len];
        for (i = 0; i < len; i++)
        {
            copy[i] = data[i];
            temp[i] = data[i];
        }
        for (i = 0; i < len; i++)
        {
            cout << copy[i] << "  " ;
            if (i > 0 && i % 10 == 0)
                cout << endl;
        }  
        cout << endl;
        cout << endl;      
        long long count = recursiveFunc(copy, temp, 0, len - 1);
        for (i = 0; i < len; i++)
        {
            cout << copy[i] << "  " ;
            if (i > 0 && i % 10 == 0)
                cout << endl;
        }
        cout << endl;
        delete[] copy;
        return count;
    }
    
    int recursiveFunc(int *data, int *copy, int start, int end)
    {
        if (start == end)
        {
//            copy[start] = data[start];
            return 0;
        }
        
        int mid = (end + start) / 2;
        
        
        int leftcount = recursiveFunc(copy, data, start, mid);
        int rightcount = recursiveFunc(copy, data, mid + 1, end);
        
        int i = mid;
        int j = end;
        int copyIndex = end;
        int count = 0;
        
        //归并的时候，就已经完成了排序了
        while (i >= start && j >= mid + 1)
        {
            if (data[i] > data[j])
            {
            	count += j - mid;
                copy[copyIndex--] = data[i--];
            }
            else 
            {
                copy[copyIndex--] = data[j--];
            }
        }
        
        while(i >= start)
        {
            copy[copyIndex--] = data[i--];
        }
        
        while(j >= mid + 1)
        {
            copy[copyIndex--] = data[j--];
        }
        
        return leftcount + rightcount + count;
    }
};

int main(void)
{
    int num[200] =
    {364,637,341,406,747,995,234,971,571,219,993,407,416,366,
    315,301,601,650,418,355,460,505,360,965,516,648,727,
    667,465,849,455,181,486,149,588,233,144,174,557,67,746,
    550,474,162,268,142,463,221,882,576,604,739,288,569,256,
    936,275,401,497,82,935,983,583,523,697,478,147,795,380,
    973,958,115,773,870,259,655,446,863,735,784,3,671,433,
    630,425,930,64,266,235,187,284,665,874,80,45,848,38,811,267,575};
    int i = 0;
    vector<int> str;
    Solution test;
    for (i = 0; num[i] > 0; i++)
    {
        str.push_back(num[i]);
    }
    
    int count = test.InversePairs(str);
    
    cout << count % 1000000007 << endl;
    return 0;
}
