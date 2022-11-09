#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

extern int is_palindrom(char string[], int len);

void print_answer(int result, FILE* output) {
	// function prints result in file
	if (result == 1) {
		fprintf(output, "%s", "YES\n");
	} else if (result == 0) {
		fprintf(output, "%s", "NO\n");
	}
}

int main(int argc, char** argv) {
	/* 
	2 variants of input:
	1) user enters 1 and then enterns two strings - full names of 
	input & output files, this means string will be taken from 
	input file (it must exist!)
	2) user enters 2, a number(seed) & full output file name, 
	this means the string will be generated, 
	the number is a generator seed and 
	the result will be copied to the output file 
	*/
	if (argc != 4) {  // argv[0] is the name of executed file
        	printf("Command line must have 1-st arguement - input type (1 - enter the input & output file names and use them to do the task - then finish; 2 - use generator, enter generator seed & full output file name)\n");
        	return 1;
        }
        int n, seed;
        FILE *input, *output;
        
	const int arr_size = 20000;  
	char str[arr_size];  // making static array with enough length
	int size;

	/* INPUT begin */
	if (atoi(argv[1]) == 1) {  // read string from file "input.txt" (IT MUST EXIST!)
        	input = fopen(argv[2], "r");
        	fgets(str, arr_size, input);
        	// printf("size: %d", size); -> for DEBUG
        	size = strlen(str) - 1;
		for (int i = 0; i < size; ++i) {
			fscanf(input, "%c", &(str[i]));
		}
		fclose(input);
        } else {  // generate string 
        	seed = atoi(argv[2]);
		srand(seed);
        	size = rand() % 10 + 1;
        	printf("size: %d\n", size);
        	for (int i = 0; i < size; ++i) {
        		// all symbols:
			// str[i] = 'A' - 65 + rand() % 128;  // 0 <= int(str[i]) <= 127 
			// in order to simplify checking results we will generate 
			// only English letters (capital & lowercase) - 'A' = 65, 'z' = 122
			str[i] = 'A' + rand() % 58;
			printf("%c", str[i]);
		}
		printf("\n");
        }
        /* INPUT end */
	
	/* OUTPUT begin */
	// we always (notwithstanding the input variant option) have 2 outputs: 
	// in file "output.txt" & in console
	
	clock_t t;
        t = clock();  // НАЧАЛО ЗАМЕРА ВРЕМЕНИ
	int is_palindrom_ = is_palindrom(str, size);
	int sum = 0;
	const int iterations_num = 3000000;  
	// 3M iterations is enough for string A(x517) to slow down algo speed
	// execution time is more than 1 sec (see in console)
	for (int i = 0; i < iterations_num; ++i) {  // extra cycles in order to slow down the algorithm
		is_palindrom_ = is_palindrom(str, size);
	}
	t = clock() - t;  // КОНЕЦ ЗАМЕРА ВРЕМЕНИ
	double time_taken = ((double) t)/ CLOCKS_PER_SEC; // in seconds
	
	output = fopen(argv[3], "w");
	print_answer(is_palindrom_, output);
	fclose(output);
        
	printf("Is palindrom? ");
	if (is_palindrom_ == 1) {
		printf("YES\n");
	} else {
		printf("NO\n");
	}
	printf("TIME: %f sec\n", time_taken); 
	/* OUTPUT end */
	
	return 0;
}
