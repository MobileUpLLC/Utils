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
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            exact: "5.6.1"
        ),
        .package(
            url: "https://github.com/kean/Pulse",
            exact: "2.1.2"
        )
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: ["Alamofire", "Pulse", .product(name: "PulseUI", package: "Pulse")])
    ]
)
