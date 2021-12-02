#include <stdio.h>

int input[] = {199, 200, 208, 210, 200, 207, 240, 269, 269, 263};

int sol1(int list[], int size) {
    int i;
    int ctr = 0;
    for(i = 1; i < size; i++) {
        if(list[i] > list[i-1]) {
            ctr++;
        }
    }
    return ctr;
}

int sol2(int list[], int size) {
    int i;
    int ctr = 0;
    int lastval = list[0] + list[1] + list[2];
    for(i = 3; i < size-2; i++) {
        int sum = list[i] + list[i+1] + list[i+2];
        if(sum > lastval) {
            ctr++;
        }
        lastval = sum;
    }
    return ctr;
}

int main(void) {
    int size = sizeof input / sizeof input[0];
    printf("Part 1: %i\n", sol1(input, size));
    printf("Part 2: %i\n", sol2(input, size));
    return 0;
}
