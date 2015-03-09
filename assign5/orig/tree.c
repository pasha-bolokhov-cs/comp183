/*
 *
 * COMP169 Lab2
 *
 * Simple expression tree routines for expression compiler.
 *
 * April 8, 1993, Deryk Barker.
 *
 */

#include    "global.h"
#include    "tree.h"

NODE        *
MakeApp     (int    oper, NODE *l, NODE *r){

NODE        *newp;

 newp = (NODE *) malloc (sizeof (NODE));
 newp->type = oper;
 newp->body.child.left = l;
 newp->body.child.right = r;

 return (newp);

}

NODE        *
MakeLeaf    (int num){

NODE        *newp;

 newp = (NODE *) malloc (sizeof (NODE));
 newp->type = NUM;
 newp->body.value = num;

 return (newp);

}
