/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     MAIN = 258,
     INT = 259,
     STRING = 260,
     CHAR = 261,
     READ = 262,
     IF = 263,
     ELSE = 264,
     PRINT = 265,
     WHILE = 266,
     ARR = 267,
     PLUS = 268,
     MINUS = 269,
     TIMES = 270,
     DIV = 271,
     LESS = 272,
     LESSEQ = 273,
     EQ = 274,
     NEQ = 275,
     BIGGEREQ = 276,
     EQQ = 277,
     BIGGER = 278,
     SQRT = 279,
     REMAINDER = 280,
     SQUAREBRACKETOPEN = 281,
     SQUAREBBRACKETCLOSE = 282,
     SEMICOLON = 283,
     BRACKETOPEN = 284,
     BRACKETCLOSE = 285,
     CURLYBRACKETOPEN = 286,
     CURLYBRACKETCLOSE = 287,
     COMMA = 288,
     IDENTIFIER = 289,
     INTCONSTANT = 290,
     STRINGCONSTANT = 291,
     AND = 292,
     OR = 293
   };
#endif
/* Tokens.  */
#define MAIN 258
#define INT 259
#define STRING 260
#define CHAR 261
#define READ 262
#define IF 263
#define ELSE 264
#define PRINT 265
#define WHILE 266
#define ARR 267
#define PLUS 268
#define MINUS 269
#define TIMES 270
#define DIV 271
#define LESS 272
#define LESSEQ 273
#define EQ 274
#define NEQ 275
#define BIGGEREQ 276
#define EQQ 277
#define BIGGER 278
#define SQRT 279
#define REMAINDER 280
#define SQUAREBRACKETOPEN 281
#define SQUAREBBRACKETCLOSE 282
#define SEMICOLON 283
#define BRACKETOPEN 284
#define BRACKETCLOSE 285
#define CURLYBRACKETOPEN 286
#define CURLYBRACKETCLOSE 287
#define COMMA 288
#define IDENTIFIER 289
#define INTCONSTANT 290
#define STRINGCONSTANT 291
#define AND 292
#define OR 293




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

