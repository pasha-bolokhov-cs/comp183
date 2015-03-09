CC = gcc
CFLAGS = -c
OFLAGS = -o
OBJECTS = lex.o lab6b.o machine.o parser.o tree.o
SOURCES = lex.c lab6b.c machine.c parser.c tree.c

all:
	$(CC) $(OFLAGS) lab6b $(SOURCES)

%.o: %.c
	$(CC) $(CFLAGS) $<

clean:
	rm -f *.o lab6b
