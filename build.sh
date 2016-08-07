#!/bin/bash
#
# Wrapper around `swift build' that uses pkg-config in config.sh
# to determine compiler and linker flags
#
. ./config.sh
gtk=`echo Packages/Gtk-3*/Sources/Gtk-3.0.swift`
[ -e $gtk ] || ./generate-wrapper.sh
swift build $CCFLAGS $LINKFLAGS "$@"
if [ `uname` == "Darwin" ]; then
	. ./app-bundle.sh
fi
