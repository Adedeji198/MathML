#include <string.h>
#include <stdio.h>
#include <malloc.h>
#include "utils.h"

char *addStrings(char *s1, char* s2){
	char *ret;
	ret= (char *)malloc(
		sizeof(char)* (
			strlen(s1)+
			strlen(s2)+
			1
		)
	);

	strcpy(ret,s1);
	strcat(ret,s2);

	return ret;
}

char *addStrings_f(char *s1, char* s2){
	char *ret;
	ret= (char *)malloc(
		sizeof(char)* (
			strlen(s1)+
			strlen(s2)+
			1
		)
	);

	strcpy(ret,s1);
	strcat(ret,s2);

	free(s1);

	return ret;
}
