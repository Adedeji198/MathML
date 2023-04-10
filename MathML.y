%{
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define YYSTYPE char*
#include "utils.h"
extern char * mystring;


%}



%token NUMBER ID INT COMMA SEMICOLON PI THETA
%token CUP CAP GE LE EQUAL ARROW LT GT MEMBER NOTMEMBER PLUS MINUS TIMES 
%token DIVIDE  
%token ROOT SQRT POWER SUB SUBSUP NEG DELTA DEL
%token LEFT RIGHT LEFTP RIGHTP LCURL RCURL
%token END

%left CUP CAP GE LE EQUAL ARROW LT GT MEMBER NOTMEMBER
%left PLUS MINUS TIMES
%left DIVIDE  SUB  COLON SEMICOLON COMMA INT
%left NEG LCURL RCURL ROOT SQRT SUBSUP
%right POWER 
%right DEL DELTA

%start Input

%%

Input:
	
	| Input Line
;

Line:
	END
	| Expression END { printf("<math xmlns = \"http://www.w3.org/1998/Math/MathML\">\n%s</math>\n", $1); }
;

Expression:
	NUMBER { $$=$1; }
	| ID { $$=$1; }
	| PI { $$ = "<mi>π</mi>"}
	| THETA { $$ = "<mi>θ</mi>"}
	| SQRT Expression{
		$$ =addStrings_f(
			addStrings(
				"<msqrt>\n",$2
			),
			"\n</msqrt>\n"
		);

	}
	| ID SUBSUP Expression COMMA Expression{
		$$=addStrings_f(
			addStrings_f(
				addStrings_f(
					addStrings(
						"<msubsup>\n",
						$1
					),
					$3
				),
				$5
			),
			"</msubsup>\n"
		);
		/*  */
	}
	| INT SUBSUP Expression COMMA Expression{
		$$=addStrings_f(
			addStrings_f(
				addStrings_f(
					addStrings(
						"<msubsup>\n",
						"∫"
					),
					$3
				),
				$5
			),
			"</msubsup>\n"
		);
	}
	| Expression PLUS Expression  { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>+</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| Expression SUB Expression  { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					"<msub>\n",
					$1
				),
				$3
			),
			"</msub>\n"
		); 
	}

	| Expression MINUS Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>-</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| Expression TIMES Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>×</mo>\n"
				),
				$3
			),
			"\n"
		);
	}
	| Expression DIVIDE Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					"<mfrac>\n",$1
				),
				$3
			),
			"</mfrac>\n"
		); 
	}
	| Expression POWER Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					"<msup>\n",$1
				),
				$3
			),
			"</msup>\n"
		); 
	}	
	| Expression CUP Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>∪</mo>\n"
				),
				$3
			),
			"\n"
		);
	}
	| Expression CAP Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>∩</mo>\n"
				),
				$3
			),
			"\n"
		);
	}

	| Expression GE Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>&#x2265;</mo>\n"
				),
				$3
			),
			"\n"
		);
	} 
	| Expression LE Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>&#x2264;</mo>\n"
				),
				$3
			),
			"\n"
		);
	}
	| Expression EQUAL Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>=</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| Expression ARROW Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>→</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}	
	| Expression LT Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>&lt;</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| Expression GT Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>&gt;</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| Expression MEMBER Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>∈</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| Expression NOTMEMBER Expression { 
	
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					$1,"<mo>∉</mo>\n"
				),
				$3
			),
			"\n"
		); 
	}
	| LEFT Expression RIGHT { 
		$$ =addStrings_f(
			addStrings(
				"<mrow>\n",$2
			),
			"</mrow>\n"
		);

	}
	| LEFTP Expression RIGHTP { 
		$$ =addStrings_f(
			addStrings(
				"<mrow>\n<mo>(</mo>\n",$2
			),
			"\n<mo>)</mo>\n</mrow>\n"
		);

	}
	| Expression ROOT Expression { 
		$$=addStrings_f(
			addStrings_f(
				addStrings(
					"<mroot>\n",$1
				),
				$3
			),
			"</mroot>\n"
		); 
	}
	| LCURL Expression RCURL {
		$$ = addStrings_f(
			addStrings("<mo>{</mo>\n",$2),
			"<mo>}</mo>\n"
		);
	}
	| MINUS Expression %prec NEG { $$ = addStrings("<mo>-</mo>", $2); }
	| DELTA Expression { $$ = addStrings("<mo>Δ</mo>", $2); }
	| DEL   Expression { $$ = addStrings("<mo>δ</mo>", $2); }
	| Expression SEMICOLON Expression {
	  $$ =
	         addStrings_f(
			 addStrings($1,"<mo> </mo>\n"),
			 $3
		) ;
	}
;

%%

int yyerror(char *s) {
  printf("%s\n", s);
}


int main() {
  FILE *fd;
  fd = fopen("input.mth","rt");
  yyset_in(fd);
  if (yyparse())
	fprintf(stderr, "Successful parsing.\n");
  else
	fprintf(stderr, "error found.\n");
}
