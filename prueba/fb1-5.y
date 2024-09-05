%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

/* Declare tokens */
%token <num> NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL

/* Operator precedence and associativity */
%left ADD SUB
%left MUL DIV
%right ABS

%%

calclist: /* nothing */
    | calclist exp EOL { printf("= %g\n> ", $2); }
    | calclist EOL { printf("> "); } /* Blank line or a comment */
    ;

exp: factor
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    ;

factor: term
    | factor MUL term { $$ = $1 * $3; }
    | factor DIV term { $$ = $1 / $3; }
    ;

term: NUMBER
    | ABS term { $$ = fabs($2); }
    | OP exp CP { $$ = $2; }
    ;

%%

int main() {
    printf("> ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "error: %s\n", s);
}

