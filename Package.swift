// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"])
    ],
    targets: [
        .target(
            name: "Utils"
        )
    ]
)
