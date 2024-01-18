%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count = 0;

int stIndex = 0;

typedef struct SymbolEntry {
    char name[50];
    int type; // 0 identifier, 1 int, and 2 string
    struct SymbolEntry *next;
} SymbolEntry;

typedef struct PIFEntry {
    char name[50];
    int index;
    struct PIFEntry *next;
} PIFEntry;

SymbolEntry *symbolTable = NULL;
PIFEntry *pifTable = NULL;

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

int addToSymbolTable(char *name, int type) {
    int duplicateIndex = findDuplicateIndex(name);

    if (duplicateIndex != -1) {
        return duplicateIndex;
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
    stIndex += 1;

    return stIndex - 1;
}

void addToPIF(char *name, int index) {
    PIFEntry *newEntry = (PIFEntry *)malloc(sizeof(PIFEntry));
    if (!newEntry) {
        fprintf(stderr, "Memory allocation error for PIF entry.\n");
        exit(1);
    }

    strcpy(newEntry->name, name);
    newEntry->index = index;
    newEntry->next = pifTable;
    pifTable = newEntry;
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

"cat"|"main"|"read"|"write"|"number"|"string"|"array"|"while"|"if"|"else"|"dog"|"function"|"length"|"return" {
    addToPIF(yytext, -1);
}

"+"|"-"|"*"|"/"|"%"|"<"|"<="|"!="|"="|">="|"=="|"<>"|">"|"&&"|"||" {
    addToPIF(yytext, -1);
}

"["|"]"|";"|"("|")"|"{"|"}"|","|":"|"." {
    addToPIF(yytext, -1); // Add separator to PIF with index -1
}

{identifier} {
    addToPIF("id", addToSymbolTable(yytext, 0));
}

{identifierwrong} {
    printf("Error at token %s at line %d\n", yytext, count);
    exit(1);
}

{number} {
    addToPIF("int", addToSymbolTable(yytext, 1));
}

{string} {
    addToSymbolTable("string", addToSymbolTable(yytext, 2));
}

[ \t]+ {}

[\n]+ {++count;}

. {
    // printf("Error at token %s at line %d\n", yytext, count); // Commented out
    exit(1);
}

%%

int yywrap() {
    return 1;
}

void printSymbolTable() {
SymbolEntry *current = symbolTable;
    SymbolEntry *stack = NULL; // Use a stack to reverse the order

    printf("\nReversed Symbol Table:\n");
    printf("| %-5s | %-20s | %-15s |\n", "Index", "Name", "Type");
    printf("|--------|----------------------|------------------|\n");

    int index = 0;
    while (current != NULL) {
        // Push current entry onto the stack
        SymbolEntry *temp = current->next;
        current->next = stack;
        stack = current;
        current = temp;
    }

    // Print entries from the stack
    while (stack != NULL) {
        char typeString[20];
        switch (stack->type) {
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

        printf("| %-5d | %-20s | %-15s |\n", index, stack->name, typeString);

        // Pop entry from the stack
        SymbolEntry *temp = stack->next;
        stack->next = current;
        current = stack;
        stack = temp;

        index++;
    }
}

void printPIF() {
    PIFEntry *current = pifTable;
    PIFEntry *stack = NULL; // Use a stack to reverse the order

    printf("\nReversed PIF:\n");
    printf("| %-20s | %-15s |\n", "Name", "Index");
    printf("|----------------------|------------------|\n");

    while (current != NULL) {
        // Push current entry onto the stack
        PIFEntry *temp = current->next;
        current->next = stack;
        stack = current;
        current = temp;
    }

    // Print entries from the stack
    while (stack != NULL) {
        printf("| %-20s | %-15d |\n", stack->name, stack->index);

        // Pop entry from the stack
        PIFEntry *temp = stack->next;
        stack->next = current;
        current = stack;
        stack = temp;
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
    printPIF();

    // Cleanup code, if needed
    SymbolEntry *current = symbolTable;
    while (current != NULL) {
        SymbolEntry *temp = current->next;
        free(current);
        current = temp;
    }

    PIFEntry *currentPIF = pifTable;
    while (currentPIF != NULL) {
        PIFEntry *tempPIF = currentPIF->next;
        free(currentPIF);
        currentPIF = tempPIF;
    }

    if (argc > 1) {
        fclose(yyin);
    }

    return 0;
}

