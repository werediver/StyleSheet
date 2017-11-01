[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-blue.svg)](https://swift.org/)
![Platforms: iOS, macOS](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-brightgreen.svg)](https://cocoapods.org/)

# StyleSheet

An approach to define reusable and composable UI styles.

Having some base styles defined you can use them like so:

```swift
final class TitleLabel: UILabel, TitleFontStyle {}
final class BodyLabel: UILabel, BodyFontStyle, MultilineLabelStyle {}
final class CaptionLabel: UILabel, CaptionFontStyle, MultilineLabelStyle {}
```

![Example screenshot](Images/example-composed.png)

For a complete usage example see the [Example](Example/) project.

For the implementation details see [`Style.swift`](Sources/Style.swift) and [`RootStyle.swift`](Sources/RootStyle.swift).

## Motivation

### Why to define the UI style in code?

Defining the UI style in code is good because it gives

- _reproducible_,
- _reusable_,
- and _composable_ results.

### Why not to use UIAppearance?

Because we can do better. By avoiding the use of the appearance-proxy we can access _all_ properties and methods (not only `UI_APPEARANCE_SELECTOR` and `dynamic`), and nested objects!

## Supported base classes

| Base class               | UIAppearance | StyleSheet | Notes               |
|--------------------------|--------------|------------|---------------------|
| NSView                   |              | ✓          |                     |
| UIView                   | ✓            | ✓          |                     |
| UIBarItem                | ✓            | ✗          | See the issue [#1](https://github.com/werediver/StyleSheet/issues/1) |

## Installation

### Carthage

```
github "werediver/StyleSheet" ~> 4.0
```

### CacoaPods

```ruby
pod 'StyleSheet', :git => 'https://github.com/werediver/StyleSheet.git', :tag => 'v4.0.0'
```

Note: check the latest available version!

## License

[MIT](https://github.com/werediver/StyleSheet/blob/master/LICENSE)
