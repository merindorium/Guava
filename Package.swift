// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Guava",
    platforms: [
        .iOS(.v12), .macOS(.v10_10)
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
            dependencies: ["Guava"])
    ]
)
