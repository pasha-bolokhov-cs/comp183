#
# Compile all source files
#

# could use "wildcard" to include all '.c' files, but this 
# wouldn't work if the user makes a backup copy of any of the '.c' file
SRC = assign5.c error.c lex.c parser.c tree.c

# just all '.h' files in the current directory
HDR = $(wildcard *.h)

# convert SRC into a list of objects
OBJ = $(SRC:.c=.o)
TARGET = assign5

$(TARGET): $(OBJ) $(SRC) $(HDR)
	$(CC) -o $(TARGET) $(OBJ)

$(OBJ): $(SRC) $(HDR)

clean:
	-$(RM) $(OBJ) $(TARGET) *~

