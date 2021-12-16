#include "counter.h"

static int count = 0;

int count_up()
{
    return ++count;
}

int count_down()
{
    if (count == 0)
        return 0;
    else 
        return --count;
}