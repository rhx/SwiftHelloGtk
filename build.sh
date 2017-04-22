#!/bin/bash
#
# Wrapper around `swift build' that uses pkg-config in config.sh
# to determine compiler and linker flags.
#
# On macOS (Darwin), this script uses gtk-mac-bundler to create an app
#
. ./config.sh
gtk=`echo .build/checkouts/SwiftGtk.*/Sources/Gtk-3.0.swift`
[ -e $gtk ] || ./generate-wrapper.sh
swift build $CCFLAGS $LINKFLAGS "$@"
if [ `uname` = "Darwin" ]; then
	. ./app-bundle.sh
fi
