@echo off
bison --define=math.tab.h -oMathParser.c MathML.y
flex  -oMathLexer.c MathML.lex
make
