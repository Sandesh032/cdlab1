%{
#include<stdio.h>
%}

%%
[aeiouAEIOU] {printf("%s:Vowel\n",yytext);}
[a-zA-Z] {printf("%s:Consonant\n",yytext);}
. {printf("Neither");}
%%

int main() {
yylex();
return 0;
}

int yywrap() {
return 1;
}