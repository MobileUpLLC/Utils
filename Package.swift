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
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.6.1")
        )
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: ["Alamofire"])
    ]
)
