// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KyuSwiftPackages",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "KyuGenericExtensions",
            targets: ["KyuGenericExtensions"]),
        .library(
            name: "KyuNetworkExtensions",
            targets: ["KyuNetworkExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .upToNextMajor(from: "4.1.0")),
    ],
    targets: [
        .target(
            name: "KyuGenericExtensions",
            path: "Sources/KyuGenericExtensions"),
        .target(
            name: "KyuNetworkExtensions",
            dependencies: ["KyuGenericExtensions", "Moya", "ObjectMapper"],
            path: "Sources/KyuNetworkExtensions"),
        .testTarget(
            name: "KyuSwiftPackagesTests",
            dependencies: ["KyuGenericExtensions", "KyuNetworkExtensions"]),
    ]
)
