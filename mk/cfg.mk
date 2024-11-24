# cfg
ANYFLAGS  = -Iinc -Itmp -O0 -g3
 CFLAGS   += $(ANYFLAGS) -std=gnu99
 XFLAGS   += $(ANYFLAGS) -std=gnu++11
TCFLAGS  += $(ANYFLAGS)
TLFLAGS  += -Wl,--print-memory-usage
