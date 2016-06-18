#!/bin/sh
#
# Recursive swift code wrapper generator for gobject-introspection (.gir) files.
# This calls the non-recursive gir-to-swift.sh to do the heavy lifting.
#
. ./config.sh
./package.sh fetch
for gen in Packages/*/gir-to-swift.sh ; do
	echo "Generate Swift Wrapper for `dirname $gen | cut -d/ -f2`"
	( cd `dirname $gen` && ./`basename $gen` "$@" )
done
