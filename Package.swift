// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineXAsync",
    platforms: [.macOS("10.10"), .iOS("9.0"), .tvOS("9.0"), .watchOS("2.0")],
    products: [
        .library(name: "CombineXAsync", targets: ["CombineXAsync"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cx-org/CombineX", .upToNextMinor(from: "0.3.0"))
    ],
    targets: [
        .target(name: "CombineXAsync", dependencies: ["CombineX"]),
        .testTarget(name: "CombineXAsyncTests", dependencies: ["CombineXAsync"]),
    ],
    swiftLanguageVersions: [.v5]
)
