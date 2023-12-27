// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "HelloGtk",
    dependencies: [
        .package(url: "https://github.com/rhx/SwiftGtk.git",  branch: "gtk4"),
    ],
    targets: [
        .executableTarget(name: "HelloGtk", dependencies: [
            .product(name: "Gtk", package: "SwiftGtk")
        ]),
    ]
)
