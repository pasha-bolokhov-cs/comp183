/*
 *
 * COMP169 Lab2.
 *
 * Error handler for simple expression compiler.
 *
 * Adapted from Aho, Sethi and Ullman 'Compilers: Principles, Techniques
 * and Tools' (aka the New Dragon Book), pp73-78.
 *
 * Adapted and typed April 7, 1993, Deryk Barker.
 *
 */

#include   <stdlib.h>  /* Prototype for exit */

#include   "global.h"
#include   "error.h"

void
error       (char *m){  /* Emit error message and give up */

  fprintf (stderr, "line %d: %s\n", lineno, m);
  exit (1);

}
