// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "ENSNormalize",
    products: [
        .library(
            name: "ENSNormalize",
            targets: ["ENSNormalize"]
        )
    ],
    targets: [
        .target(
            name: "ENSNormalize",
            path: "Sources/ENSNormalize",
            resources: [
                .process("data")
            ]
        ),
        .testTarget(
            name: "ENSNormalizeTests",
            dependencies: ["ENSNormalize"],
            path: "Tests/ENSNormalizeTests",
            resources: [
                .process("tests")
            ]
        ),
    ]
)
