# SwiftHelloGtk

A simple 'hello-world' app using SwiftGtk

## Building and Running

Make sure you have all the prerequisites installed (see below).  After that, you can simply clone this repository and build the command line executable (be patient, this will download all the required dependencies and take a while to compile) using

	git clone https://github.com/rhx/SwiftHelloGtk.git
	cd SwiftHelloGtk
    swift run
	
Alternatively, you can just build the program and run manually using

    swift build
	.build/debug/HelloGtk

On macOS you can also create an App bundle that you can move to your `/Applications` folder and double-click by running the following script:

	./app-bundle.sh

This will create a `HelloGtk.app` inside the `.build/app/` folder.

### Xcode

On macOS, you can build the project using Xcode instead.  To do this, you need to create an Xcode project first, then open the project in the Xcode IDE:

	./xcodegen.sh
	open HelloGtk.xcodeproj

After that, select the executable target (not the Bundle/Framework target with the same name as the executable) and use the (usual) Build and Run buttons to build/run your project.

## What is new?

### Support for gtk 4.x

There now are `gtk4` and `gtk4-monorepo` branches,
supporting the latest version of gtk.

### Other notable changes

Version 11 introduces a new type system into `gir2swift`,
to ensure it has a representation of the underlying types.
This is necessary for Swift 5.3 onwards, which requires more stringent casts.
As a consequence, accessors can accept and return idiomatic Swift rather than
underlying types or pointers.
This means that a lot of the changes will be source-breaking for code that
was compiled against libraries built with earlier versions of `gir2swift`.

 * Requires Swift 5.2 or later (Swift 5.3 is required for the `gtk4` branch)
 * Wrapper code is now `@inlinable` to enable the compiler to optimise away most of the wrappers
 * Parameters and return types use more idiomatic Swift (e.g. `Ref` wrappers instead of pointers, `Int` instead of `gint`, etc.)
 * Functions that take or return records now are templated instead of using the type-erased Protocol
 * `ErrorType` has been renamed `GLibError` to ensure it neither clashes with `Swift.Error` nor the `GLib.ErrorType`  scanner enum
 * Parameters or return types for records/classes now use the corresponding, lightweight Swift `Ref` wrapper instead of the underlying pointer


## Prerequisites

### Swift

Building should work with at least Swift 5.6. You can download Swift from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well (install them using `xcode-select --install`).  Test that your compiler works using `swift --version`, which should give you something like

	$ swift --version
    swift-driver version: 1.87.3 Apple Swift version 5.9.2 (swiftlang-5.9.2.2.56 clang-1500.1.0.2.5)
    Target: arm64-apple-macosx14.0

on macOS, or on Linux you should get something like:

	$ swift --version
	Swift version 5.9.2 (swift-5.9.2-RELEASE)
	Target: x86_64-unknown-linux-gnu

### Gtk 3.22 or higher

The Swift wrappers have been tested with
glib-2.56, 2.58, 2.60, 2.62, 2.64, 2.66, 2.68, 2.70, 2.72, 2.74, 2.76 and 2.78,
and gdk/gtk-3.22 and 3.24, as well as 4.0, 4.2, 4.4, 4.6, 4.8, 4.10 and 4.12
on the `gtk4` branch.  They should work with higher versions, but YMMV.
Also make sure you have `gobject-introspection` and its `.gir` files installed.

#### Linux

##### Ubuntu

On Ubuntu 22.04, you can use the gtk that comes with the distribution.  Just install with the `apt` package manager:

        sudo apt update
        sudo apt install libgtk-4-dev gir1.2-gtksource-4.0 libcogl-pango-dev libcogl-path-dev libcogl-dev libpango1.0-dev gir1.2-pango-1.0 libgdk-pixbuf2.0-dev gir1.2-gdkpixbuf-2.0 libgraphene-1.0-dev gir1.2-graphene-1.0 libglib2.0-dev glib-networking libatk1.0-dev libatk-bridge2.0-dev libcogl-dev libcogl-pango-dev gobject-introspection libgirepository1.0-dev libxml2-dev jq

##### Fedora

On Fedora 29, you can use the gtk that comes with the distribution.  Just install with the `dnf` package manager:

    sudo dnf install gtk4-devel pango-devel cairo-devel cairo-gobject-devel glib2-devel gobject-introspection-devel libxml2-devel jq

#### macOS

On macOS, you can install gtk using HomeBrew (for setup instructions, see http://brew.sh).  Once you have a running HomeBrew installation, you can use it to install a native version of gtk:

	brew update
    brew install gtk4 glib glib-networking gobject-introspection pkg-config jq

## Troubleshooting

Here are some common errors you might encounter and how to fix them.

### Old Swift toolchain or Xcode

If you get an error such as

	$ ./build.sh 
	error: unable to invoke subcommand: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-package (No such file or directory)
	
this probably means that your Swift toolchain is too old.  Make sure the latest toolchain is the one that is found when you run the Swift compiler (see above).

  If you get an older version, make sure that the right version of the swift compiler is found first in your `PATH`.  On macOS, use xcode-select to select and install the latest version, e.g.:

	sudo xcode-select -s /Applications/Xcode.app
	xcode-select --install
