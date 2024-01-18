%{
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"

int yyerror(char *s);

#define YYDEBUG 1
%}

%token MAIN;
%token INT;
%token STRING;
%token CHAR;
%token READ;
%token IF;
%token ELSE;
%token PRINT;
%token WHILE;
%token ARR;

%token PLUS;
%token MINUS;
%token TIMES;
%token DIV;
%token LESS;
%token LESSEQ;
%token EQ;
%token NEQ;
%token BIGGEREQ;
%token EQQ;
%token BIGGER;
%token SQRT;
%token REMAINDER;


%token SQUAREBRACKETOPEN;
%token SQUAREBBRACKETCLOSE;
%token SEMICOLON;
%token BRACKETOPEN;
%token BRACKETCLOSE;
%token CURLYBRACKETOPEN;
%token CURLYBRACKETCLOSE;
%token COMMA;

%token IDENTIFIER;
%token INTCONSTANT;
%token STRINGCONSTANT;

%token AND;
%token OR;

%start Main

%%
Main : MAIN BRACKETOPEN BRACKETCLOSE CURLYBRACKETOPEN CompoundStatement CURLYBRACKETCLOSE     { printf("Main -> MAIN() { CompoundStatement }\n"); }
        ;
CompoundStatement : Statement SEMICOLON CompoundStatement     { printf("CompoundStatement -> Statement ; CompoundStatement\n"); }
                  | Statement SEMICOLON                       { printf("CompoundStatement -> Statement ;\n"); }
                  ;
Statement : DeclarationStatement     { printf("Statement -> DeclarationStatement\n"); }
          | AssignmentStatement     { printf("Statement -> AssignmentStatement\n"); }
          | IfStatement     { printf("Statement -> IfStatement\n"); }
          | WhileStatement     { printf("Statement -> WhileStatement\n"); }
          | PrintStatement     { printf("Statement -> PrintStatement\n"); }
          ;
DeclarationStatement : Type IDENTIFIER  COMMA DeclarationStatement     { printf("DeclarationStatement -> IDENTIFIER ( Type ) , DeclarationStatement\n"); }
                     | Type IDENTIFIER       { printf("DeclarationStatement -> IDENTIFIER ( Type )\n"); }
                     ;
Type : INT     { printf("Type -> int\n"); }
     | STRING     { printf("Type -> str\n"); }
     | ARR     { printf("Type -> arr\n"); }
     ;
AssignmentStatement : IDENTIFIER EQ Expression     { printf("AssignmentStatement -> IDENTIFIER = Expression\n"); }
                    | IDENTIFIER EQ ArrayStatement     { printf("AssignmentStatement -> IDENTIFIER = ArrayStatement\n"); }
                    ;
Expression : Expression PLUS Term     { printf("Expression -> Expression + Term\n"); }
           | Expression MINUS Term     { printf("Expression -> Expression - Term\n"); }
           | Term     { printf("Expression -> Term\n"); }
           ;
Term : Term TIMES Factor     { printf("Term -> Term * Factor\n"); }
     | Term DIV Factor     { printf("Term -> Term / Factor\n"); }
     | Factor     { printf("Term -> Factor\n"); }
     ;
Factor : BRACKETOPEN Expression BRACKETCLOSE     { printf("Factor -> ( Expression )\n"); }
       | IDENTIFIER     { printf("Factor -> IDENTIFIER\n"); }
       | INTCONSTANT     { printf("Factor -> INTCONSTANT\n"); }
       | MINUS IDENTIFIER     { printf("Factor -> - IDENTIFIER\n"); }
       | SQRT BRACKETOPEN Expression BRACKETCLOSE     { printf("Factor -> sqrt ( Expression )\n"); }
       ;
ArrayStatement : SQUAREBRACKETOPEN SQUAREBBRACKETCLOSE    { printf("ArrayStatement -> []\n"); }
               | SQUAREBRACKETOPEN ExpressionList SQUAREBBRACKETCLOSE    { printf("ArrayStatement -> [ ExpressionList ]\n"); }
               ;
ExpressionList : Expression COMMA ExpressionList    { printf("ExpressionList -> Expression , ExpressionList\n"); }
               | Expression    { printf("ExpressionList -> Expression\n"); }
               ;
IfStatement : IF BRACKETOPEN Condition BRACKETCLOSE CURLYBRACKETOPEN CompoundStatement CURLYBRACKETCLOSE  { printf("IfStatement -> if Expression { CompoundStatement }\n"); }


            ;
WhileStatement : WHILE BRACKETOPEN Condition BRACKETCLOSE CURLYBRACKETOPEN CompoundStatement CURLYBRACKETCLOSE  { printf("WhileStatement -> while Expression { CompoundStatement }\n"); }
              ;
PrintStatement : PRINT BRACKETOPEN Expression BRACKETCLOSE     { printf("PrintStatement -> print ( Expression )\n"); }
Condition : Expression Relation Expression     { printf("Condition -> Expression Relation Expression\n"); }
          ;

LogicCondition : Condition LogicRelation Condition     { printf("Condition -> Expression Relation Expression\n"); }
        | Condition
          ;

LogicRelation : AND     { printf("LogicRelation -> and\n"); }
         | OR     { printf("LogicRelation -> or\n"); }

Relation : LESS     { printf("Relation -> <\n"); }
         | LESSEQ     { printf("Relation -> <=\n"); }
         | EQQ     { printf("Relation -> ==\n"); }
         | NEQ     { printf("Relation -> <>\n"); }
         | BIGGEREQ     { printf("Relation -> >=\n"); }
         | BIGGER     { printf("Relation -> >\n"); }
         ;
%%
int yyerror(char *s) {
    printf("Error: %s", s);
}

extern FILE *yyin;

int main(int argc, char** argv) {
    if (argc > 1) 
        yyin = fopen(argv[1], "r");
    if (!yyparse()) 
        fprintf(stderr, "\tOK\n");
}