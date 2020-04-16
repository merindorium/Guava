# Guava 

![build](https://github.com/merindorium/Guava/workflows/build/badge.svg?branch=master)
![Swift 5.x](https://img.shields.io/badge/Swift-5.x-orange.svg)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20linux-lightgray.svg)
![version 1.0.0](https://img.shields.io/badge/version-1.0.0-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Features

Guava provides several types of test doubles:

- Stub
- Spy
- Fake

# Installation

## Carthage

Update your `Cartfile` with:

```
github "merindorium/Guava"
```

## Swift Package Manager

To use `Guava` with SPM update your `Package.swift`.

```swift
import PackageDescription

let package = Package(
    name: "ExampleProject",
    dependencies: [
        .package(url: "https://github.com/merindorium/Guava.git", from: "v1.0.0")
    ],
    ...
)

```

## Manual

> ⚠️ This will install `Carthage` on your system

You could manually build Guava for iOS and MacOS by using:

1. `make release_tooling`
2. `make carthage_build`
