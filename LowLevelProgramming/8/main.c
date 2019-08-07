/*
  gcc -c -o main.o main.c
  gcc -c -fPIC -o dynamiclib.o dynamiclib.c
  gcc -o dynamiclib.so -shared dynamiclib.o
  gcc -o main main.o dynamiclib.so
  objdump -D -Mintel-mnemonic dynamiclib.so
*/

extern void libfun(const int value);

const int global = 100;

int main()
{
    libfun(42);
    return 0;
}
