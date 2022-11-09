#include <stdio.h>
#include <string.h>

int is_palindrom(char string[], int len) {
	// function returns 1 when string is a palidrom
	// 0 in the opposite case
	// printf("len: %d", len); -> for DEBUG
	for (int i = 0; i < len/2+1; ++i) {
		if (string[i] != string[len-i-1]) {
			return 0;
		}
	}
 	return 1;
}
