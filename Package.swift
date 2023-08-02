// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "WaniKani",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "WaniKani",
            targets: ["WaniKani", "WaniKaniTestResources"]
        )
    ],
    targets: [
        .target(
            name: "WaniKani",
            dependencies: []
        ),
        .target(
            name: "WaniKaniTestResources",
            dependencies: ["WaniKani"]
        ),
        // Tests
        .testTarget(
            name: "WaniKaniTests",
            dependencies: ["WaniKani", "WaniKaniTestResources"]
        ),
    ]
)
