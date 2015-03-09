/*
 *
 * COMP169 Lab2.
 *
 * Header file for parse tree print and evaluation routines.
 *
 * Written 9 April, 1993, Deryk Barker.
 *
 * PrintParseTree is passed the address of the root node of a tree
 * representing an arithmetic expression. It will print an expression
 * which corresponds to the tree, using parentheses to eliminate
 * ambiguity and the need for precedence assumptions.
 *
 * E.g. if the NODE pointer points to the tree:
 *
 *                  +
 *                 / \
 *                /   \
 *               *     5
 *              / \
 *             /   \
 *            -     7
 *           / \
 *          /   \
 *         6     3
 *
 * PrintParseTree's output will be:
 *  ((6-3)*7)+5
 *
 * PrintPostTree prints out the postfix representation of the tree, by doing
 * a postorder traversal, print the left subtree, then the right, then
 * the operator at the node.
 *
 * So, for the above tree, PrintPostTree prints:
 *  6 3 - 7 * 5 +
 *
 * EvaluateParseTree will evaluate the expression tree by recursively
 * evaluating left and right subtrees and applying operators to them.
 * The final value will be returned as the result of EvaluateParseTree.
 * In the case of the tree above, EvaluateParseTree will return the value 26.
 * EvaluateParseTree should also free up the space occupied by each subtree
 * as it is evaluated. EvaluateParseTree is a simple version of a
 * tree 'reduction' machine.
 *
 */

#ifndef __MACHINE_H

#include    "tree.h"

extern  void    PrintParseTree     (NODE *);
extern  void    PrintPostTree	   (NODE *);
extern  int     EvaluateParseTree  (NODE *);

#define __MACHINE_H
#endif
