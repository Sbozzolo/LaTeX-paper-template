#!/bin/sh

# find finds all the tikz files in the figures folder, then returns
# the names

# sed prepend the correct strings needed to compile with make

# xargs compiles with make

# TODO: This script is not really needed, it should be possible to do this
#       directly with Makefile

# HACK: Here xargs could be used with -r to prevent the execution of make when
#       the list is empty. This works on GNU xargs, but fails with other
#       implementations. As a workaround, we check if the directory is empty
#       so that the code is portable

if [ $(find figures -type f -name "*.tikz") ]
then
    find figures -type f -name "*.tikz" -exec basename {} '.tikz' \; | sed -e 's/^/img\ IMG=/' | xargs -r make
fi
