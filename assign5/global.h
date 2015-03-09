/*
 *
 * COMP169 Lab2.
 *
 * Header file for simple expression compiler.
 *
 * Adapted from Aho, Sethi and Ullman 'Compilers: Principles, Techniques
 * and Tools' (aka the New Dragon Book), pp73-78.
 *
 * Adapted and typed April 7, 1993, Deryk Barker.
 *
 */

#ifndef __GLOBAL_H

#include        <stdio.h>       /* I/O routine definitions */
#include        <ctype.h>       /* Character test routines etc. */

#define NONE    -1
#define EOS     '\0'

#define NUM     256
#define DONE    257

extern  int       tokenval;       /* Value of token attribute */

extern  int       lineno;

#define __GLOBAL_H
#endif
