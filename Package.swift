// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "HelloGtk",
    dependencies: [
        .package(name: "gir2swift", url: "https://github.com/rhx/gir2swift.git", .branch("development")),
        .package(name: "Gtk", url: "https://github.com/rhx/SwiftGtk.git", .branch("gtk4-development")),
    ],
    targets: [
        .target(name: "HelloGtk", dependencies: ["Gtk"]),
    ]
)
