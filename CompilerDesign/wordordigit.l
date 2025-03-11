%{
#include<stdio.h>
%}

%%
[a-zA-Z]* {printf("%s is Word",yytext);}
[0-9]* {printf("%s is Digit",yytext);}
. | \n {printf("Invalid\n");}
%%

int main() {
yylex();
return 0;
}

int yywrap() {
return 1;
}