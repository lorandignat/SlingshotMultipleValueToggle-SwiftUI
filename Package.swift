// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SlingshotMultipleValueToggle",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SlingshotMultipleValueToggle",
            targets: ["SlingshotMultipleValueToggle"]),
    ],
    targets: [
        .target(
            name: "SlingshotMultipleValueToggle",
            exclude: ["../../Showcase/showcase.gif"]
        ),
    ]
)
