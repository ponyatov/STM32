#include "vm.h"

// main memory
byte M[Msz];
mptr Cp = 0;
mptr Ip = 0;

// return stack
ptr R[Rsz];
sptr Rp = 0;

// data stack
cell D[Dsz];
sptr Dp = 0;
