%{

#include<stdio.h>
#include<stdlib.h>
int count=0;
char target_word[100];

%}

%%
[a-zA-Z]+ {  // Match any word
    if (strcmp(yytext, target_word) == 0) {  // Compare with user input
        count++;
    }
}
.|\n {}
%%

int main() {

printf("Enter the word to search:\n");
scanf("%s",target_word);

FILE* fp=fopen("input1.txt","r");

if(!fp) {
printf("Couln't open file");
return 0;
}

yyin=fp;
yylex();

printf("\nfrequency of %s is %d",target_word,count);

fclose(fp);
return 0;
}

int yywrap() {
return 1;
}