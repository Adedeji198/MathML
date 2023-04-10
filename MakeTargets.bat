@echo off

if 0%1%==01 goto perfom_task1
if 0%1%==02 goto perfom_task2
if 0%1%==03 goto perfom_task3

echo Usage:  MakeTarget index 
echo where index = 1 - 3

echo 1. make MathParser.o 
echo 2. make MathLexer.o 
echo 3. make utils.o 

goto done_all

:perfom_task1
cls
make MathParser.o
goto done_all

:perfom_task2
cls
make MathLexer.o
goto done_all

:perfom_task3
cls
make utils.o
goto done_all


:done_all
echo done
