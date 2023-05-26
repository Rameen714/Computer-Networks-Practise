#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/*
a)	Reads the text file Input_File.txt and displays its data on terminal. [3]

b)	Write only the integers from the Input_File.txt file to another file which will be created at runtime. [3]

c)	Write non-alphabet words (non-alphabet word is the one in which all letters are non-alphabet e.g., “a#$2#” is not a non-alphabet word but “$%^&#32” is a non-alphabet word) from the Input_File.txt file into another text file which will be created at run-time. [6]

d)	Invert all the words in Input_File.txt file which contain one or more vowels and write the complete content (with inverted and non-inverted words) into another file which will be created at run time. For example ‘computer’ will be inverted to ‘retupmoc’.

*/

void function1(char* filename)
{
	printf("\n-----------------------------------------------------");
	printf("\nAll Data:\n");
	FILE* fp;
	char buff[1000];
	fp = fopen(filename,"r");
	printf("\nThe data in the file: ");
	char c;
	c = fgetc(fp);
	
	while(c != EOF)
	{
		fprintf("%c",c);
		c = fgetc(fp);
	}
	
}

void function2(char* filename)
{
	printf("\n-----------------------------------------------------");
	printf("\nIntgers Only:\n");
	FILE* fp;
	char buff[1000];
	fp = fopen(filename,"r");
	printf("\nThe data in the file: ");
	char c;
	c = fgetc(fp);
	
	File* fp2;
	fp2 = fopen("output.txt","w");
	while(c != EOF)
	{
		if(isdigit(c) > 0)
			fprintf(fp2,"%c",c);
		c = fgetc(fp);

	}
}

void function3(char* filename)
{
	printf("\n-----------------------------------------------------");
	printf("\nin function3\n");
	FILE* fp;
	char buff[10];
	fp = fopen(filename,"r");
	
	FILE* fp2 = fopen("output3.txt","w+");
	printf("\nThe data in the file: ");
	//char c;
	//c = fgetc(fp);
	//char* buff;
	while(fscanf(fp,"%s",buff) != EOF)
	{
		if(isalpha(buff) == 0)
			fprintf(fp2,"%s",buff);
	}
}

int main(int args, char** argv)
{
	printf("\nNo of args: %d",args);
	printf("\nArgv: %s\n",argv[1]);	
	function1(argv[1]);
	//printf("\n");	
	function2(argv[1]);
	//printf("\n");
	function3(argv[1]);
	printf("\n");
	return 0;
}
