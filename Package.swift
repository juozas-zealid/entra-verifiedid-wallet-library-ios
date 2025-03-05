// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "WalletLibrary",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "WalletLibrary",
            targets: ["WalletLibrary"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WalletLibrary",
            path: "WalletLibrary/WalletLibrary")
    ]
)
