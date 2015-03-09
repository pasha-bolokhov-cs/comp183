#
#

SRC = assign5.c error.c lex.c parser.c tree.c
HDR = $(wildcard *.h)
OBJ = $(SRC:.c=.o)
TARGET = assign5

$(TARGET): $(OBJ) $(SRC) $(HDR)
	$(CC) -o $(TARGET) $(OBJ)

$(OBJ): $(SRC) $(HDR)

clean:
	-$(RM) $(OBJ) $(TARGET) *~
