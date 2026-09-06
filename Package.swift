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
            url: "https://github.com/kerimovq5-blip/SilentMoonDomain",
            branch: "main"
        ),
        
    ],
    targets: [
        .target(
            name: "PresentationLayer",
            dependencies: [
                
                .product(name: "SilentMoonDomain", package: "SilentMoonDomain"),
            ],
            path: "Sources/SilentMoonPresentationLayer"
        ),
    ],
    swiftLanguageModes: [.v6]
)
