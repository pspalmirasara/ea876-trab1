VERBOSE ?= 1

all: lex.yy.c y.tab.c
	gcc -omainz lex.yy.c y.tab.c -ll

lex.yy.c:main.l y.tab.c
	lex main.l

y.tab.c:main.y
	bison -dy main.y

test: all
	sh test.sh ./mainz $(VERBOSE)

clean:
	rm y.tab.c lex.yy.c y.tab.h mainz xml/belem/*.csv xml/corumba/*.csv xml/joao_monlevade/*.csv xml/nova_lima/*.csv xml/parauapebas/*.csv xml/rio_de_janeiro/*.csv xml/sao_luis/*.csv
