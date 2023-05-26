#include<stdio.h>
#include<stdlib.h>

void main()
{
	short a = 0x1234;
	char* c = (char*)&a;
	printf("\nData:%x\n",*c);
	// prints 34 //implies its big endian
}
