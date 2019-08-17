// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "HelloGtk",
    dependencies: [
        .package(url: "https://github.com/rhx/SwiftGtk.git", .branch("master")),
    ],
    targets: [
        .target(name: "HelloGtk", dependencies: ["Gtk"]),
    ]
)
