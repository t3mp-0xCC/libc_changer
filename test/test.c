#include <stdio.h>
#include <stdlib.h>
#include <gnu/libc-version.h>

// show linked glibc version
int main(int argc, char *argv[]) {
  printf("%s\n", gnu_get_libc_version());
}
