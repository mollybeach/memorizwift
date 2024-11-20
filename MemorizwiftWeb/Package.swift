// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MemorizwiftWeb",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "MemorizwiftWeb", targets: ["MemorizwiftWeb"])
    ],
    dependencies: [
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0")
    ],
    targets: [
        .executableTarget(
            name: "MemorizwiftWeb",
            dependencies: [
                .product(name: "TokamakDOM", package: "Tokamak")
            ],
            path: "Sources/MemorizwiftWeb"
        )
    ]
)
