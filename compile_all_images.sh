#!/bin/sh

# find finds all the tikz files in the figures folder, then returns
# the names

# sed prepend the correct strings needed to compile with make

# xargs compiles with make

# TODO: This script is not really needed, it should be possible to do this
#       directly with Makefile

# HACK: Here xargs is with -r to prevent the execution of make when the list is
#       empty. This works on GNU xargs, but fails with other implementations.

find figures -type f -name "*.tikz" -exec basename {} '.tikz' \; | sed -e 's/^/img\ IMG=/' | xargs -r make
