#include <stdio.h>

int input[] = {...}

int main() {
    int i;
    int ctr = 0;
    int size = sizeof input / sizeof input[0]
    for(i = 1; i < size; i++) {
	if(input[i] > input[i-1]) {
	    ctr++;
	}
    }
    printf("%i", ctr);
    return 0;
}
