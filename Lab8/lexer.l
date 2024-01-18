%{
#include <stdio.h>
int count = 0;
%}
letter      [a-zA-Z]
nonnulldigit [1-9]
digit       [0-9]
number      [+-]?{nonnulldigit}{digit}*|0
char        ({letter}|{digit})
identifier  {letter}({letter}|{digit})*
identifierwrong ({digit})+({letter})+({letter}|{digit})*


%%
"cat"|"main"|"read"|"write"|"number"|"string"|"array"|"while"|"if"|"else"|"dog"|"function"|"length" {printf("%s - reserved word\n", yytext);}

"+"|"-"|"*"|"/"|"%"|"<"|"<="|"!="|"="|">="|"=="|"<>"|">"|"&&"|"||" printf("%s - operator\n", yytext);
"["|"]"|";"|"("|")"|"{"|"}"|","|":"|"." printf("%s - separator\n", yytext);

{identifier}    {printf("%s - identifier\n", yytext);}
{identifierwrong} {printf("Error at token %s at line %d\n", yytext, count); exit(1);}

{number} {printf("%s - integer constant\n", yytext);}

[ \t]+ {}

[\n]+ {++count;}

. {printf("Error at token %s at line %d\n", yytext, count); exit(1);}

%%

int yywrap(){return 0;}

int main(int argc, char **argv ) 
{ 
   if (argc > 1) 
        yyin = fopen(argv[1], "r");
    else 
        yyin = stdin;
    yylex();
}