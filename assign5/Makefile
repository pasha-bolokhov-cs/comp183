#
# Compile all source files
#

# all '.c' files
SRC = $(wildcard *.c)

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

