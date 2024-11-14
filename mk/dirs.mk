# dirs
CWD   = $(CURDIR)
ifneq (,$(wildcard $(HOME)/distr/cross))
CROSS = $(HOME)/distr/cross
endif
BIN   = $(CWD)/bin
LIB   = $(CWD)/lib
INC   = $(CWD)/inc
SRC   = $(CWD)/src
TMP   = $(CWD)/tmp
