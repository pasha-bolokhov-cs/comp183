/*
 *
 * COMP169 Lab2.
 *
 * Header file for parser for simple expression compiler.
 *
 * Adapted from Aho, Sethi and Ullman 'Compilers: Principles, Techniques
 * and Tools' (aka the New Dragon Book), pp73-78.
 *
 * Adapted and typed April 7, 1993, Deryk Barker.
 *
 */

#ifndef __PARSER_H

#include    "tree.h"

/*
 *
 * Parser parses a single expression, to be typed in by the user.
 *
 * Input parameters: None.
 *
 * Output parameters:
 *      nodep   a pointer to a NODE pointer. If the parse is successful,
 *              *nodep will contain a pointer to a tree representing the
 *              parsed expression. If the parse fails, *nodep will be NULL.
 * Returned value:
 *      DONE    if EOF was encountered in the input stream.
 *      Other   otherwise. (Usually ';' for end of expression, but not
 *              to be relied upon).
 *
 */

extern  int         Parse       (NODE **);

#define __PARSER_H
#endif
