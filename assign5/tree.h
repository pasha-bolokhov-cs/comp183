/*
 *
 * COMP169 Lab2
 *
 *Header file for simple expression tree routines for expression compiler.
 *
 * April 8, 1993, Deryk Barker.
 *
 */

#ifndef __TREE_H

#include    <stdlib.h>

typedef struct node{
  int type;
  union {
    int value;
    struct {
      struct node *left, *right;
    } child;
  } body;
} NODE;

extern  NODE    *MakeApp    (int, NODE *, NODE *);
extern  NODE    *MakeLeaf   (int);

#define __TREE_H
#endif
