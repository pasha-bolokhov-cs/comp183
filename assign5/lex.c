/*
 *
 * COMP169 Lab2.
 *
 * Lexical analyser for simple expression compiler.
 *
 * Adapted from Aho, Sethi and Ullman 'Compilers: Principles, Techniques
 * and Tools' (aka the New Dragon Book), pp73-78.
 *
 * Adapted and typed April 7, 1993, Deryk Barker.
 *
 */

#include    "global.h"  /* Our definitions */
#include    "lex.h"     /* My definition */

int         lineno      = 1;
int         tokenval    = NONE;

static  int lasttoken   = NONE;
static  int t;


void
LexInit     (void){

  printf ("=> ");
  lasttoken = ';';    /* This is a kludge */
  lineno = 1;


}

void
LexReset    (void){

  while (t != '\n')
    t = getchar ();

}


int
LexAnalyse  (void){

  while (1){
    t = getchar ();
    if (t == ' ' || t == '\t')
      ;               /* Strip whitespace */
    else if (t == '\n'){
      lineno++;
      if (lasttoken == NONE)
	printf ("=> ");
      else if (lasttoken != ';')
	printf ("=& ");
      else
	return (NONE);
    }
    else if (isdigit (t)){  /* Handle number */
      ungetc (t, stdin);
      scanf ("%d", &tokenval);
      lasttoken = NUM;
      return NUM;
    }
    else if (t == EOF)
      return DONE;
    else{                    /* None of the above */
      tokenval = NONE;
      lasttoken = t;
      return t;
    }
  }
}


