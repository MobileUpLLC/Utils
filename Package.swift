// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: [])
    ]
)
