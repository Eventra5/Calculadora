%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *);
extern char expression[1000]; // Declarar la variable global que contiene la expresión
%}

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"|"             { return '|'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"("             { return '('; }
")"             { return ')'; }
"+"             { return '+'; }
"="             { return '='; }
"\*\*"          { return POWER; }
"sqrt"          { return SQRT; }
"mod"           { return MOD; }
"<<"            { return LSHIFT; }
">>"            { return RSHIFT; }
\n              ;

%%

int main() {
    yylex();
    return 0;
}