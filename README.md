# SwiftHelloGtk
A simple 'hello-world' app using SwiftGtk

## Building
Make sure you have all the prerequisites installed (see below).  After that, you can simply clone this repository and build the command line executable (be patient, this will download all the required dependencies and take a while to compile) using

	git clone https://github.com/rhx/SwiftHelloGtk.git
	cd SwiftHelloGtk
	./build.sh
	
After that, you can run the program using

	.build/debug/HelloGtk

A simple, empty 'Hello World' window should appear.  To exit the program, click the close button or press Control-C in the Terminal window.

### Xcode

On macOS, you can build the project using Xcode instead.  To do this, you need to create an Xcode project first, then open the project in the Xcode IDE:


	./xcodegen.sh
	open HelloGtk.xcodeproj

After that, select the executable target (not the Bundle/Framework target with the same name as the executable) and use the (usual) Build and Run buttons to build/run your project.


## Prerequisites

### Swift

Building should work with at least Swift 4 (Swift 5 should work as well). You can download Swift from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well (install them using `xcode-select --install`).  Test that your compiler works using `swift --version`, which should give you something like

	$ swift --version
	Apple Swift version 5.1.3 (swiftlang-1100.0.282.1 clang-1100.0.33.15)
	Target: x86_64-apple-darwin19.4.0

on macOS, or on Linux you should get something like:

	$ swift --version
	Swift version 5.1.5 (swift-5.1.5-RELEASE)
	Target: x86_64-unknown-linux-gnu

### Gtk 3.18 or higher

The Swift wrappers have been tested with glib-2.46, 2.48, 2.52, 2.56, 2.58, 2.60, 2.62, and 2.64, and gdk/gtk 3.18, 3.20, 3.22, and 3.24.  They should work with higher versions, but YMMV.  Also make sure you have `gobject-introspection` and its `.gir` files installed.

#### Linux

##### Ubuntu

On Ubuntu 18.04 and 16.04 you can use the gtk that comes with the distribution.  Just install with the `apt` package manager:

	sudo apt update
	sudo apt install libgtk-3-dev gir1.2-gtksource-3.0 gobject-introspection libgirepository1.0-dev libxml2-dev

If you prefer a newer version of gtk, you can also install it from the GNOME 3 Staging PPA (see https://launchpad.net/~gnome3-team/+archive/ubuntu/gnome3-staging), but be aware that this can be a bit dangerous (as this removes packages that can be vital, particularly if you use a GNOME-based desktop), so only do this if you know what you are doing:

	sudo add-apt-repository ppa:gnome3-team/gnome3-staging
	sudo apt update
	sudo apt dist-upgrade
	sudo apt install libgtk-3-dev gir1.2-gtksource-3.0 gobject-introspection libgirepository1.0-dev libxml2-dev

##### Fedora

On Fedora 29, you can use the gtk that comes with the distribution.  Just install with the `dnf` package manager:

	sudo dnf install gtk3-devel pango-devel cairo-devel cairo-gobject-devel glib2-devel gobject-introspection-devel libxml2-devel

#### macOS

On macOS, you can install gtk using HomeBrew (for setup instructions, see http://brew.sh).  Once you have a running HomeBrew installation, you can use it to install a native version of gtk:

	brew update
	brew install gtk+3 glib glib-networking gobject-introspection pkg-config


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

