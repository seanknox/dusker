// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "DuskerKit",
    platforms: [
        .iOS(.v16),
        .watchOS(.v9),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "DuskerKit",
            targets: ["DuskerKit"]),
    ],
    dependencies: [
        // Dependencies go here
    ],
    targets: [
        .target(
            name: "DuskerKit",
            dependencies: [],
            path: "Sources/DuskerKit",
            resources: [
                .process("Models/DuskerDataModel.xcdatamodeld"),
                .process("Models/README.md")
            ]),
        .testTarget(
            name: "DuskerKitTests",
            dependencies: ["DuskerKit"]),
    ]
) 