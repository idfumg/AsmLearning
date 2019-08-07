#include <stdio.h>

extern const int global;

void libfun(const int value)
{
    printf("param: %d\n", value);
    printf("global: %d\n", global);
}
