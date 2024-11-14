%{
    #include "parser.h"
    char nofile[] = "";
    char* yyfile = nofile;
%}

%option noyywrap yylineno

%%
.           {yyerror("");}      // error on any undetected char
