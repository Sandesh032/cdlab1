%{
#define YYSTYPE double
#include <stdio.h>
#include "calculator.tab.h"
%}

DIG         [0-9]
LOG         log
LOG10       log10

%%

{DIG}+      { yylval = atof(yytext); return NUM; }
"+"         { return PLS; }
"-"         { return MNS; }
"*"         { return MUL; }
"/"         { return DIV; }
"\n"        { return NWL; }
"("         { return LFT; }
")"         { return RIT; }
{LOG}       { return LOG; }
{LOG10}     { return LOG10; }

%%

int yywrap() {
    return 1;
}