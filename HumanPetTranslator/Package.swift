// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "HumanPetTranslator",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "HumanPetTranslator",
            targets: ["HumanPetTranslator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
        .package(url: "https://github.com/kaishin/Gifu.git", from: "3.3.1")
    ],
    targets: [
        .target(
            name: "HumanPetTranslator",
            dependencies: [
                "SnapKit",
                "Gifu"
            ]),
        .testTarget(
            name: "HumanPetTranslatorTests",
            dependencies: ["HumanPetTranslator"]),
    ]
) 