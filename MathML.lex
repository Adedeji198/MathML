%{
#define YYSTYPE char*
#include "math.tab.h"
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "utils.h"
char * mystring;

%}

white [ \t]+
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer})?{exponent}?
variable [A-Za-z]+
Nvariable [0-9]+[A-Za-z]+
%%

{white} { }
{variable} {
	yylval = addStrings_f(
		addStrings("<mi>", yytext ),
		"</mi>\n"
	); 
    return ID;
}
{Nvariable} {
	yylval = addStrings_f(
		addStrings("<mi>", yytext ),
		"</mi>\n"
	); 
    return ID;
}
{real} { 

	yylval = addStrings_f(
		addStrings("<mn>", yytext ),
		"</mn>\n"
	);
       
    
	return NUMBER;
}

"+" return PLUS;
"-" return MINUS;
"*" return TIMES;
"/" return DIVIDE;
"^" return POWER;
"(" return LEFT;
")" return RIGHT;
"\n" return END;
"<cup>" return CUP;
"<cap>" return CAP;
">=" return GE;
"<=" return LE;
"=" return EQUAL;
"<" return LT;
">" return GT;
"<in>" return MEMBER;
"<nin>" { return NOTMEMBER; }
"_" return SUB;
"_^" return SUBSUP;
"<sqrt>" return SQRT;
"<root>" return ROOT;
"[" return LEFTP;
"]" return RIGHTP;
"{" return LCURL;
"}" return RCURL;
":" return COLON;
"<int>" return INT;
"," return COMMA;
"->" return ARROW;
";" return SEMICOLON;
"<pi>" return PI;
"<delta>" return DELTA;
"<del>" return DEL;
"<theta>" return THETA;
%%
