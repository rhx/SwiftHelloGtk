import PackageDescription

let package = Package(
    name: "SwiftGtkApp",
    dependencies: [
        .Package(url: "https://github.com/rhx/SwiftGtk.git", Version("3.18.0-2.46")!)
    ]
)
