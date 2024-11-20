// swift-tools-version:5.8
import PackageDescription
let package = Package(
    name: "TokamakApp",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .executable(name: "TokamakApp", targets: ["TokamakApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0")
    ],
    targets: [
        .executableTarget(
            name: "TokamakApp",
            dependencies: [
                "TokamakAppLibrary",
                .product(name: "TokamakShim", package: "Tokamak")
            ]),
        .target(
            name: "TokamakAppLibrary",
            dependencies: []),
        .testTarget(
            name: "TokamakAppLibraryTests",
            dependencies: ["TokamakAppLibrary"]),
    ]
)