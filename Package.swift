// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "HelloGtk",
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git", branch: "main"),
        .package(url: "https://github.com/rhx/SwiftGtk.git",  branch: "monorepo"),
    ],
    targets: [
        .target(name: "HelloGtk", dependencies: [
            .product(name: "Gtk", package: "SwiftGtk")
        ]),
    ]
)
