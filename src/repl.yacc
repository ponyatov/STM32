%{
    #include "parser.h"
%}

%defines %union { int n; char *s; char c; }

%%
REPL :
