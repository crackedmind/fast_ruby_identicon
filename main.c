
#include <stdio.h>
#include "siphash.h"
char key[16] = "\x00\x11\x22\x33\x44\x55\x66\x77\x88\x99\xAA\xBB\xCC\xDD\xEE\xFF";

int main(int argc, char **argv)
{
  printf("%d\n", sip_hash24(key, "crackedmind", strlen("crackedmind")));
  printf("%d\n", sip_hash24(key, "crackedmind1", strlen("crackedmind1")));
return 1;
}