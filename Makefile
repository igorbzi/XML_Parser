all:
	yacc -d xml_parser.y
	lex xml_parser.l
	gcc -o parser y.tab.c lex.yy.c -lfl

clean:
	rm y.tab.c
	rm y.tab.h
	rm parser
	rm lex.yy.c