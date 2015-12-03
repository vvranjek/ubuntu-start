/* params.def - Run-time parameters.
   Copyright (C) 2001-2013 Free Software Foundation, Inc.
   Written by Mark Mitchell <mark@codesourcery.com>.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 3, or (at your option) any later
version.

GCC is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING3.  If not see
<http://www.gnu.org/licenses/>.  */

/* This file contains definitions for language-independent
   parameters.  The DEFPARAM macro takes 6 arguments:

     - The enumeral corresponding to this parameter.

     - The name that can be used to set this parameter using the
       command-line option `--param <name>=<value>'.

     - A help string explaining how the parameter is used.

     - A default value for the parameter.

     - The minimum acceptable value for the parameter.

     - The maximum acceptable value for the parameter (if greater than
     the minimum).

   Be sure to add an entry to invoke.texi summarizing the parameter.  */

/* When branch is predicted to be taken with probability lower than this
   threshold (in percent), then it is considered well predictable. */
DEFPARAM (PARAM_PREDICTABLE_BRANCH_OUTCOME,
	  "predictable-branch-outcome",
	  "Maximal estimated outcome of branch considered predictable",
	  2, 0, 50)

DEFPARAM (PARAM_INLINE_MIN_SPEEDUP,
	  "inline-min-speedup",
	  "The minimal estimated speedup allowing inliner to ignore inline-insns-single and inline-isnsns-auto",
	  10, 0, 0)

/* The single function inlining limit. This is the maximum size
   of a function counted in internal gcc instructions (not in
   real machine instructions) that is eligible for inlining
   by the tree inliner.
   The default value is 450.
   Only functions marked inline (or methods defined in the class
   definition for C++) are affected by this.
   There are more restrictions to inlining: If inlined functions
   call other functions, the already inlined instructions are
   counted and once the recursive inline limit (see
   "max-inline-insns" parameter) is exceeded, the acceptable size
   gets decreased.  */
DEFPARAM (PARAM_MAX_INLINE_INSNS_SINGLE,
	  "max-inline-insns-single",
	  "The maximum number of instructions in a single function eligible for inlining",
	  400, 0, 0)

/* The single function inlining limit for functions that are
   inlined by virtue of -finline-functions (-O3).
   This limit should be chosen to be below or equal to the limit
   that is applied to functions marked inlined (or defined in the
   class declaration in C++) given by the "max-inline-insns-single"
   parameter.
   The default value is 40.  */
DEFPARAM (PARAM_MAX_INLINE_INSNS_AUTO,
	  "max-inline-insns-auto",
	  "The maximum number of instructions when automatically inlining",
	  40, 0, 0)

DEFPARAM (PARAM_MAX_INLINE_INSNS_RECURSIVE,
	  "max-inline-insns-recursive",
	  "The maximum number of instructions inline function can grow to via recursive inlining",
	  450, 0, 0)

DEFPARAM (PARAM_MAX_INLINE_INSNS_RECURSIVE_AUTO,
	  "max-inline-insns-recursive-auto",
	  "The maximum number of instructions non-inline function can grow to via recursive inlining",
	  450, 0, 0)

DEFPARAM (PARAM_MAX_INLINE_RECURSIVE_DEPTH,
	  "max-inline-recursive-depth",
	  "The maximum depth of recursive inlining for inline functions",
	  8, 0, 0)

DEFPARAM (PARAM_MAX_INLINE_RECURSIVE_DEPTH_AUTO,
	  "max-inline-recursive-depth-auto",
	  "The maximum depth of recursive inlining for non-inline functions",
	  8, 0, 0)

DEFPARAM (PARAM_MIN_INLINE_RECURSIVE_PROBABILITY,
	  "min-inline-recursive-probability",
	  "Inline recursively only when the probability of call being executed exceeds the parameter",
	  10, 0, 0)

/* Limit of iterations of early inliner.  This basically bounds number of
   nested indirect calls early inliner can resolve.  Deeper chains are still
   handled by late inlining.  */
DEFPARAM (PARAM_EARLY_INLINER_MAX_ITERATIONS,
	  "max-early-inliner-iterations",
	  "The maximum number of nested indirect inlining performed by early inliner",
	  1, 0, 0)

/* Limit on probability of entry BB.  */
DEFPARAM (PARAM_COMDAT_SHARING_PROBABILITY,
	  "comdat-sharing-probability",
	  "Probability that COMDAT function will be shared with different compilation unit",
	  20, 0, 0)

/* Limit on probability of entry BB.  */
DEFPARAM (PARAM_PARTIAL_INLINING_ENTRY_PROBABILITY,
	  "partial-inlining-entry-probability",
	  "Maximum probability of the entry BB of split region (in percent relative to entry BB of the function) to make partial inlining happen",
	  70, 0, 0)

/* Limit the number of expansions created by the variable expansion
   optimization to avoid register pressure.  */
DEFPARAM (PARAM_MAX_VARIABLE_EXPANSIONS,
	  "max