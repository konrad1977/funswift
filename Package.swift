// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Funswift",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Funswift",
            targets: ["Funswift"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Funswift",
            dependencies: []),
        .testTarget(
            name: "FunswiftTests",
            dependencies: ["Funswift"]),
    ]
)
