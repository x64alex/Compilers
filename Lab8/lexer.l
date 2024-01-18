%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count = 0;

typedef struct SymbolEntry {
    char name[50];
    int type; // 0 identifer, 1 int, and 2 string
    struct SymbolEntry *next;
} SymbolEntry;

SymbolEntry *symbolTable = NULL;

int findDuplicateIndex(char *name) {
    SymbolEntry *current = symbolTable;
    int index = 0;

    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return index; // Entry with the same name already exists at this index
        }

        current = current->next;
        index++;
    }

    return -1; // No duplicate found
}

void addToSymbolTable(char *name, int type) {
    int duplicateIndex = findDuplicateIndex(name);

    if (duplicateIndex != -1) {
        printf("Duplicate entry for %s at index %d - ignoring\n", name, duplicateIndex);
        return;
    }

    SymbolEntry *newEntry = (SymbolEntry *)malloc(sizeof(SymbolEntry));
    if (!newEntry) {
        fprintf(stderr, "Memory allocation error for symbol table entry.\n");
        exit(1);
    }

    strcpy(newEntry->name, name);
    newEntry->type = type;
    newEntry->next = symbolTable;
    symbolTable = newEntry;
}

%}

letter      [a-zA-Z]
nonnulldigit [1-9]
digit       [0-9]
number      {nonnulldigit}{digit}*|0
string      (\"({letter}|{digit})*\")
char        ({letter}|{digit})
identifier  {letter}({letter}|{digit})*
identifierwrong ({digit})+({letter})+({letter}|{digit})*

%%

"cat"|"main"|"read"|"write"|"number"|"string"|"array"|"while"|"if"|"else"|"dog"|"function"|"length"|"return" {printf("%s - reserved word\n", yytext);}

"+"|"-"|"*"|"/"|"%"|"<"|"<="|"!="|"="|">="|"=="|"<>"|">"|"&&"|"||" printf("%s - operator\n", yytext);
"["|"]"|";"|"("|")"|"{"|"}"|","|":"|"." printf("%s - separator\n", yytext);

{identifier}    {addToSymbolTable(yytext, 0);}
{identifierwrong} {printf("Error at token %s at line %d\n", yytext, count); exit(1);}

{number} {addToSymbolTable(yytext, 1);}
{string} {addToSymbolTable(yytext, 2);}

[ \t]+ {}

[\n]+ {++count;}

. {printf("Error at token %s at line %d\n", yytext, count); exit(1);}

%%

int yywrap() {
    return 1;
}

void printSymbolTable() {
    SymbolEntry *current = symbolTable;
    printf("\nSymbol Table:\n");
    printf("| %-5s | %-20s | %-15s |\n", "Index", "Name", "Type");
    printf("|--------|----------------------|------------------|\n");

    int index = 0;
    while (current != NULL) {
        char typeString[20];
        switch (current->type) {
            case 0:
                strcpy(typeString, "Identifier");
                break;
            case 1:
                strcpy(typeString, "Integer");
                break;
            case 2:
                strcpy(typeString, "String");
                break;
            default:
                strcpy(typeString, "Unknown");
                break;
        }

        printf("| %-5d | %-20s | %-15s |\n", index, current->name, typeString);
        current = current->next;
        index++;
    }
}

int main(int argc, char **argv) {
    if (argc > 1)
        yyin = fopen(argv[1], "r");
    else
        yyin = stdin;

    while (yylex() != 0) {
        // Continue lexing until yywrap returns 0 (end of file)
    }

    printSymbolTable();

    // Cleanup code, if needed
    SymbolEntry *current = symbolTable;
    while (current != NULL) {
        SymbolEntry *temp = current->next;
        free(current);
        current = temp;
    }

    if (argc > 1) {
        fclose(yyin);
    }

    return 0;
}
