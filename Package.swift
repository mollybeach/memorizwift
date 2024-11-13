// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MemorizwiftWeb",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "MemorizwiftWeb", targets: ["MemorizwiftWeb"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftwasm/JavaScriptKit.git", from: "0.18.0")
    ],
    targets: [
        .executableTarget(
            name: "MemorizwiftWeb",
            dependencies: ["JavaScriptKit"],
            path: "Sources/MemorizwiftWeb"
        )
    ]
) 