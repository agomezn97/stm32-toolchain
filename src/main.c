#include <stdio.h>

#include "counter.h"

int main() 
{

    count_up();
    count_up();
    count_up();
    count_up();
    int count = count_down();
    count_up();


    printf("Hello CMake!\nCuenta = %d", count);

    return 0;
}
