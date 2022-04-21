/*bubble sorting in ascending order for a defiend data array*/
#include<stdio.h>

//march i through 0 -> n-1 th elements with for loop
//inside previous for loop march j through 0 -> n-i-1 
//swap if j th element is greater than j+1 th element

int main(void)
{
	char data[8] = {1,3,7,4,9,5,6,8};
	
	int i, j;
	int n = sizeof(data);
	for(i=0; i<n-1; i++)
	{
		for(j=0; j<n-i-1; j++)
		{
			if(data[j] > data[j+1])	
			{	
				//swapping algorithm
				data[j] = data[j] + data[j+1];
				data[j+1] = data[j] - data[j+1];
				data[j] = data[j] - data[j+1];
			}
		}	
	}
	//print the sorted array elementwise
	for(i=0; i<n; i++)
	printf("data at index %d after bubble sorting is: %d\n", i, data[i]);
}
