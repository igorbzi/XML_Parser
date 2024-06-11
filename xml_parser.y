%{
#include <stdio.h>
extern FILE *yyin;
%}

%start statement
%token DECLARATION_OPEN DECLARATION_CLOSE
%token CDATA_OPEN CDATA_CLOSE
%token COMMENT_OPEN COMMENT_CLOSE
%token TAG_BEG_OPEN TAG_END_OPEN TAG_CLOSE EMPTY_TAG_CLOSE
%token NAME ATTRIBUTE TEXT QUESTION DTD_OPEN

%%


statement:
	declaration statement
	| comment statement
	| entry statement
	| dtd statement
	| ;


dtd:
	DTD_OPEN text TAG_CLOSE;

//
declaration:
	DECLARATION_OPEN name attribute DECLARATION_CLOSE;

comment:
	COMMENT_OPEN COMMENT_CLOSE
	| COMMENT_OPEN text COMMENT_CLOSE;

entry:
	tag_beg text statement tag_end
	| tag_beg statement tag_end
	| empty_tag;

text:
	TEXT text
	| NAME text	
	| ':' text
	| '-' text
	| '=' text
	| '?' text
	| ATTRIBUTE text
	| ;

name:
	NAME attribute
	| NAME '-' name
	| NAME ':' name;


empty_tag:
	TAG_BEG_OPEN name EMPTY_TAG_CLOSE;


attribute:
	NAME '=' ATTRIBUTE attribute
	| NAME ':' attribute
	| NAME '-' attribute
	| ;


tag_beg:
	TAG_BEG_OPEN name TAG_CLOSE;


tag_end:
	TAG_END_OPEN name TAG_CLOSE;	

%%

int main(int argc, char *argv[])
{
	printf("\n# check file %s\n", argv[1]);
	yyin = fopen(argv[1], "r");
	yyparse();
}
