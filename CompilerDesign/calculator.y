%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define YYSTYPE double

int yyerror(const char *s);
extern int yylex(void);

%}

%token  PLS MNS
%token  MUL DIV
%token  NWL
%token  NUM
%token  LFT RIT
%token  LOG LOG10

%left   PLS MNS
%left   MUL DIV

%%

Seq:    /* empty */
|       Seq Line
;

Exp:    NUM                   { $$ = $1; }
|       Exp PLS Exp           { $$ = $1 + $3; }
|       Exp MNS Exp           { $$ = $1 - $3; }
|       Exp MUL Exp           { $$ = $1 * $3; }
|       Exp DIV Exp           { if ($3 == 0) { yyerror("Division by zero!"); YYABORT; } else { $$ = $1 / $3; } }
|       LOG Exp               { $$ = log($2); }
|       LOG10 Exp             { $$ = log10($2); }
|       LFT Exp RIT           { $$ = $2; }
;

Line:   NWL
|       Exp NWL               { printf("%f\n", $1); }
;

%%

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter expressions (e.g., 2 + 3, log 10, log10 100):\n");
    int ret = yyparse();
    return 0;
}