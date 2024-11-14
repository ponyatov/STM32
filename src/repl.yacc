%{
    #include "parser.h"
%}

%defines %union { int n; char *s; char c; }

%%

REPL :

%%

#include <stdlib.h>

void yyerror(const char *msg) {
    fprintf(stderr, "\n\n%s:%i %s [%s]\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
