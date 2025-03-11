%{
#include <stdio.h>
#include <stdlib.h>
%}

digit  [0-9]+
id     [a-zA-Z_][a-zA-Z0-9_]*

%%
"int"|"main"|"string"|"char"|"include"|"iostream"|"using"|"namespace"|"if"|"then"|"endl"|"cout"|"cin"|"return" { printf("\nKeyword\t%s", yytext); }

{digit} { printf("\nInteger\t%d", atoi(yytext)); }
{digit}"."{digit}+ { printf("\nFloat\t%lf", atof(yytext)); }

"=="|"+"|"-"|"*"|"/"|"="|"%"|"<"|">" { printf("\nOperator\t%s", yytext); }
[ \t\n] { /* ignore whitespaces */ }
{id} { printf("\nIdentifier\t%s", yytext); }

[,:#] { printf("\nSpecial symbol\t%s", yytext); }

. { printf("\nUnrecognized character\t%s", yytext); }

%%

int main() {
    FILE* fp = fopen("input2.txt", "r");
    if (!fp) { printf("Can't open file!"); return 0; }
    yyin = fp;
    yylex();
    fclose(fp);
    return 0;
}

int yywrap() { return 1; }