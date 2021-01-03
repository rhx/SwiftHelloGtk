#!/bin/bash
#
# Wrapper around `swift build' that uses pkg-config in config.sh
# to determine compiler and linker flags.
#
# On macOS (Darwin), this script uses gtk-mac-bundler to create an app
#
. ./config.sh
gtk=`echo $BUILD_DIR/checkouts/SwiftGtk*/Sources/Gtk/Gtk-?.0.swift`
[ -e $gtk ] || ./generate-wrapper.sh
swift build --build-path "$BUILD_DIR" $CCFLAGS $LINKFLAGS "$@"
if [ `uname` = "Darwin" ]; then
	. ./app-bundle.sh
fi
