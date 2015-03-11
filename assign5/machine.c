/*
 * Assignment 5, Computer Science 183
 * 
 * Machine implementation
 *
 * Author: Pasha Bolokhov <pasha.bolokhov@gmail.com>
 *
 * Date shown: March 10, 2015
 *
 * Keyword: RESISTANTCAT
 */
#include <stdio.h>
#include <stdlib.h>
#include "machine.h"
#include "global.h"

static struct node *root = NULL;

void PrintParseTree (struct node *tree)
{
	int top_level = 0;

	/* are we at the top level? */
	if (root == NULL) {
		root = tree;
		top_level = 1;
	}

	if (!tree)
		return;

	/* if a simple number, print and exit */
	if (tree->type == NUM) {
		printf("%d", tree->body.value);
		return;
	}

	/* a tree branching node */
	if (!top_level)
		putchar('(');

	PrintParseTree(tree->body.child.left);
	printf(" %c ", tree->type);
	PrintParseTree(tree->body.child.right);
		
	if (!top_level)
		putchar(')');

	/* reset root back to NULL for re-entrance */
	if (top_level)
		root = NULL;
}


void PrintPostTree (struct node *tree)
{
	if (tree->type == NUM) {
		printf("%d", tree->body.value);
		return;
	}

	PrintPostTree(tree->body.child.left);
	putchar(' ');
	PrintPostTree(tree->body.child.right);
	putchar(' ');
	putchar(tree->type);
}


int EvaluateParseTree (struct node *tree)
{
	int a, b;

	if (tree->type == NUM)
		return tree->body.value;

	a = EvaluateParseTree(tree->body.child.left);
	b = EvaluateParseTree(tree->body.child.right);

	switch (tree->type) {
	case '+':
		return a + b;

	case '-':
		return a - b;

	case '*':
		return a * b;

	case '/':
		return a / b;

	case '%':
		return a % b;

	default:
		fprintf(stderr, "EvaluateParseTree(): unknown operator `%c'\n", tree->type);
		exit(2);
	}
}
