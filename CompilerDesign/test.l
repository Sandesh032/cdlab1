%{
#include <stdio.h>
int pos=0,neg=0;
%}

%%
-?[0-9]+ {
if(yytext[0]=='-') neg++;
else pos++;
}
.|\n {}
%%

int main() {
    yylex();
    printf("Positive:%d\nNegative:%d\n",pos,neg);
    return 0;
}

int yywrap() {
    return 1;
}