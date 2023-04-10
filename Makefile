MathML_exe_C_SRC   =  MathParser.c MathLexer.c utils.c 
MathML_exe_CPP_SRC =  
MathML_exe_RC_SRC  =  
MathML_exe_LIB_SRC =  -lfl -lm 
MathML_exe_O_SRC   =  $(patsubst %.c,%.o, $(MathML_exe_C_SRC)) $(patsubst %.cpp,%.o,$(MathML_exe_CPP_SRC)) $(patsubst %.rc,%.o, $(MathML_exe_RC_SRC)) 




#Tools
RM       = rm.exe -f
CC       = gcc -D__DEBUG__
WINDRES  = windres.exe
ARCHIVE  = ar rcsv


#Compiler Environment
LIBS     = -L C:/MinGW/lib   -static-libgcc -lcomdlg32  -m32 -g
INC     = -I   -I.


MathML_exe = MathML.exe

all:  $(MathML_exe) 

touch: 
	touch  $(MathML_exe_C_SRC) $(MathML_exe_CPP_SRC) $(MathML_exe_RC_SRC)

clean: 
	$(RM)  $(MathML_exe_O_SRC) $(MathML_exe)


$(MathML_exe): $(MathML_exe_O_SRC)
	$(CC) $(MathML_exe_O_SRC)  -o $(MathML_exe) $(MathML_exe_LIB_SRC) $(LIBS) 

%.o: %.c
	$(CC) -c $(INC) -o $@ $^ $(warning creating c object $@)

%.o: %.cpp
	$(CC) -c $(INC) -o $@ $^ $(warning creating cpp object $@)


%.o: %.rc
	$(WINDRES)  -o $@ -i $^  $(warning creating rc object $@)


