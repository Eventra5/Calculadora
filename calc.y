%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "y.tab.h"
int yylex(void);
void yyerror(char *);
char expression[1000]; // Almacena la expresión ingresada
%}

%start Statements
%token NUMBER
%token POWER
%token SQRT
%token MOD
%token LSHIFT RSHIFT
%left '+' '-'
%left '*' '/'
%right POWER
%left MOD
%left LSHIFT RSHIFT

%%

Expr : Expr '+' Expr
     {
         $$ = $1 + $3;
         sprintf(expression, "%d + %d = %d", $1, $3, $$);
     }
     | Expr '-' Expr
     {
         $$ = $1 - $3;
         sprintf(expression, "%d - %d = %d", $1, $3, $$);
     }
     | Expr '*' Expr
     {
         $$ = $1 * $3;
         sprintf(expression, "%d * %d = %d", $1, $3, $$);
     }
     | Expr '/' Expr
     {
         if ($3 != 0) {
             $$ = $1 / $3;
             sprintf(expression, "%d / %d = %d", $1, $3, $$);
         } else {
             fprintf(stderr, "Error: División por cero\n");
             exit(1);
         }
     }
     | Expr POWER Expr
     {
         int result = 1;
         for (int i = 0; i < $3; i++) {
             result *= $1;
         }
         $$ = result;
         sprintf(expression, "%d ^ %d = %d", $1, $3, $$);
     }
     | SQRT Expr
     {
         $$ = sqrt($2);
         sprintf(expression, "sqrt(%d) = %d", $2, $$);
     }
     | Expr MOD Expr
     {
         $$ = $1 % $3;
         sprintf(expression, "%d mod %d = %d", $1, $3, $$);
     }
     | Expr LSHIFT Expr
     {
         $$ = $1 << $3;
         sprintf(expression, "%d << %d = %d", $1, $3, $$);
     }
     | Expr RSHIFT Expr
     {
         $$ = $1 >> $3;
         sprintf(expression, "%d >> %d = %d", $1, $3, $$);
     }
     | '|' Expr '|'
     {
         $$ = abs($2);
         sprintf(expression, "|%d| = %d", $2, $$);
     }
     | '(' Expr ')'
     {
         $$ = $2;
     }
     | NUMBER
     {
         $$ = $1;
         sprintf(expression, "%d", $1);
     }
     ;

Statement : Expr
          {
              printf("%s\n", expression);
          }
          ;

Statements : /* Manejar múltiples expresiones */
           | Statements Statement '='
           ;

%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

int yywrap()
{
    return 1;
}
