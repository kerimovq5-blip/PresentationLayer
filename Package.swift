// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "PresentationLayer",
    platforms: [.iOS(.v16)], 
    products: [
        .library(
            name: "PresentationLayer",
            targets: ["PresentationLayer"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kerimovq5-blip/SilentMoonData",
            branch: "main"
        ),
        .package(
            url: "https://github.com/kerimovq5-blip/SilentMoonDomain",
            branch: "main"
        ),
        .package(
            url: "https://github.com/kerimovq5-blip/SilentMoonNetwork",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "PresentationLayer",
            dependencies: [
                .product(name: "SilentMoonData", package: "SilentMoonData"),
                .product(name: "SilentMoonDomain", package: "SilentMoonDomain"),
                .product(name: "SilentMoonNetwork", package: "SilentMoonNetwork")
            ],
            path: "Sources/SilentMoonPresentationLayer"
        ),
    ],
    swiftLanguageModes: [.v6]
)
