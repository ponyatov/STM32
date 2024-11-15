/// @file
/// @brief parser headers
#pragma once

#include <stdio.h>

/// @defgroup repl repl
/// @brief interactive command line session (CLI)
/// @{
/// @defgroup parser parser
/// @brief syntax parser
/// @{

extern int yylex();                    ///< lexer
extern int yylineno;                   ///< current line number
extern char* yytext;                   ///< parsed lexeme
extern char* yyfile;                   ///< current file name
extern FILE* yyin;                     ///< file with source code
extern int yyparse();                  ///< parser
extern void yyerror(const char* msg);  ///< syntax error callback
#include "repl.parser.h"

/// @}
/// @}
