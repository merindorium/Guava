// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Guava",
    platforms: [
        .iOS(.v12), .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "Guava",
            targets: ["Guava"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Guava",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "GuavaTests",
            dependencies: ["Guava"]),
        .testTarget(
            name: "ExampleTests",
            dependencies: ["Guava"])
    ]
)
