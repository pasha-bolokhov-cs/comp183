/*
 *
 * COMP169 Lab2.
 *
 * Parser for simple expression compiler.
 *
 * Adapted from Aho, Sethi and Ullman: 'Compilers: Principles, Techniques
 * and Tools' Addison-Wesley, 1986. (aka the New Dragon Book), pp73-78.
 *
 * Adapted and typed April 7, 1993, Deryk Barker.
 *
 * The grammar this program parser is as follows (using a modified
 * extended BNF):
 *
 *      <expr>      ::= <expr> <addop> <term> ;
 *      <addop>     ::= + | -
 *      <term>      ::= <term> <mulop> <factor>
 *      <mulop>     ::= * | / | %
 *      <factor>    ::= ( <expr> ) | <number>
 *
 * As this expression is left-recursive, we modify it, using left-recursion
 * elimination (aka the 'one-track' method), to produce the following LL(1)
 * grammar:
 *
 *      <expr>      ::= <term> { <addop> <term> } ;
 *      <addop>     ::= + | -
 *      <term>      ::= <factor> { <mulop> <factor> }
 *      <mulop>     ::= * | / | %
 *      <factor>    ::= ( <expr> ) | <number>
 *
 * For more details see Davie & Morrison: 'Recursive Descent Compiling',
 * Ellis Horwood, 1981 or Bornat: 'Understanding and Writing Compilers',
 * MacMillan, 1979.
 *
 * The error detection strategy used in this is a simple-minded version
 * of Turner's SASL version, as described in Davie and Morrison. In particular
 * it makes *no* attempt to free up tree space already allocated before
 * the error was encountered. A serious compiler would, of course, do this.
 *
 * Note that: a) the lexical analyser ignore all whitespace (i.e. blanks,
 * tabs and newlines); b) every expression must be terminated by a semicolon;
 * c) EOF signifies that there are no more expressions to be evaluated.
 *
 */

#include    <setjmp.h>

#include    "global.h"
#include    "lex.h"
#include    "parser.h"
#include    "machine.h"

/*
 *
 * The following routines are all internal to the parse module.
 *
 */

static  NODE        *expr      (void);
static  NODE        *term      (void);
static  NODE        *factor    (void);
static  void         match      (int);
static  void         error      (int, int);
static  char        *textfor    (int t);

int         lookahead;

static      jmp_buf     save;

int
Parse       (NODE **nodep){ /* Parse and translate expression list */

int         status = ';';

NODE        *np;

 if (lookahead == DONE)
   return (DONE);

 if (setjmp (save) != 0){
   LexReset ();
   np = NULL;
 }
 else{
   LexInit ();
   lookahead = LexAnalyse ();
   if (lookahead == DONE)
     return (DONE);
   np = expr ();
   status = lookahead;
   match (';');
 }

 *nodep = np;
 
 return (status);

}

NODE        *
expr        (void){ /* Parse a single expression */

int         t;
NODE        *np, *tp;

 np = term ();
 while (lookahead == '+'|| lookahead == '-'){
   t = lookahead;
   match (lookahead);
   tp = term ();
   if (tp != NULL)
     np = MakeApp (t, np, tp);
   else{
     error (lookahead, NUM);
     longjmp (save, 1);
   }

 }

 return (np);

}

NODE        *
term        (void){     /* Parse a term */

int     t;
NODE        *np, *fp;

 np = factor ();
 while (lookahead == '*' || lookahead == '/' || lookahead == '%'){
   t = lookahead;
   match (lookahead);
   fp = factor ();
   if (fp != NULL)
     np = MakeApp (t, np, fp);
   else{
     error (lookahead, NUM);
     longjmp (save, 1);
   }

 }

 return (np);

}

NODE        *
factor  (void){     /* Parse a single factor */

NODE        *np;

 switch (lookahead){
   case '(':
     match ('(');
     np = expr ();
     match (')');
     break;
   case NUM:
     np = MakeLeaf (tokenval);
     match (NUM);
     break;
   case ';':       /* Empty expression */
     np = NULL;
     break;
   default:
     error (lookahead, NUM);
     longjmp (save, 1);
 }

 return (np);

}

void
match   (int t){        /* Ensure next token is correct for syntax */

  if (lookahead == t)
    lookahead = LexAnalyse ();
  else{
    error (lookahead, t);
    while (lookahead != t && lookahead != DONE)
      lookahead = LexAnalyse ();
    longjmp (save, 1);
  }

}

void
error       (int bad, int expected){    /* Emit error message */

  fprintf (stderr, "**Syntax error in line %d of expression**\n", lineno);
  fprintf (stderr, "%s found where %s expected\n\n", textfor (bad),
	   textfor (expected));

}

char        *
textfor     (int t){

static      char    optext[2] = {" "};

 switch (t){
   case '+':
   case '-':
   case '*':
   case '/':
   case '%':
   case ';':
     optext[0] = t;
     return (optext);
   case NUM:
     return ("number");
   default:
     return ("unknown token");
 }

}
