%{
#include "fb1-5.tab.h"
#include <stdio.h>
#include <stdlib.h>

/* Declare yyerror function */
void yyerror(const char *s);
%}

/* Definitions */
%%

"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
"|"         { return ABS; }
"("         { return OP; }
")"         { return CP; }
[0-9]+(\.[0-9]*)? { yylval = atof(yytext); return NUMBER; } /* Handle decimals */
\n          { return EOL; }
[ \t]       { /* Ignore white space */ }
.           { fprintf(stderr, "Mystery character %c\n", *yytext); }

%%

int yywrap() {
    return 1;
}


