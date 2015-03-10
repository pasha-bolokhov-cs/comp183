/*
 *
 * COMP183 Lab5b.
 *
 * Simple expression compiler.
 *
 * Adapted from Aho, Sethi and Ullman 'Compilers: Principles, Techniques
 * and Tools' (aka the New Dragon Book), pp73-78.
 *
 * Original adapted and typed for COMP169
 * April 7, 1993, Deryk Barker.
 *
 */

#include    "global.h"
#include    "parser.h"
#include    "machine.h"

int main (void)			/* Compiler main routine */
{
	int	 status;
	NODE	*expr;

    	status = Parse(&expr);
    	while (status != DONE) {
        	if (expr != NULL) {
            		PrintParseTree(expr);
	    		putchar ('\n');
            		PrintPostTree(expr);
	    		putchar ('\n');

            		printf ("%d\n", EvaluateParseTree (expr));
		}
	        status = Parse(&expr);
	}
    
	return (0);
}
