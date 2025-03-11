%{
#include<stdio.h>
int lines,chars;
%}

%%
['\n'] {lines++;}
. {chars++;}
%%

int main() {
yylex();
printf("Lines:%d\n",lines);
printf("Characters:%d\n",chars);
return 0;
}

int yywrap() {
return 1;
}