// swift-tools-version: 5.5.0
import PackageDescription
let package = Package(
    name: "InventoryProgram",
    platforms: [.iOS(.v11), .macOS(.v10_12)],
        products: [
            .library(
                name: "InventoryProgram",
                targets: ["InventoryProgram"]),
    ],
    dependencies: [
        .package(url: "https://github.com/metaplex-foundation/solita-swift.git", branch: "main"),
        .package(name: "Beet", url: "https://github.com/metaplex-foundation/beet-swift.git", from: "1.0.7"),
    ],
    targets: [
        .target(
            name: "InventoryProgram",
            dependencies: [
                "Beet",
                .product(name: "BeetSolana", package: "solita-swift")
            ]),
    ]
)