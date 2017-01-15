[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-blue.svg)](https://swift.org/)
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

![Plain UI](Images/example-plain-320.png) ![Styled UI](Images/example-styled-320.png)

For a complete usage example see the [Example](https://github.com/werediver/StyleSheet/tree/master/Example) project.

For the implementation details see [`Style.swift`](https://github.com/werediver/StyleSheet/blob/master/Sources/Style.swift) and [`RootStyle.swift`](https://github.com/werediver/StyleSheet/blob/master/Sources/RootStyle.swift).

## Motivation

### Why to define the UI style in code?

Defining the UI style in code is good because:

- It gives _reproducible_ results.
- It gives _reusable_ results.
- It gives _composable_ results.

### Why not to use `UIAppearance`?

Because we can do better. By avoiding the use of the appearance-proxy we can access _all_ properties and methods (not only `UI_APPEARANCE_SELECTOR` and `dynamic`), and nested objects!

## Installation

### Carthage

```
github "werediver/StyleSheet" ~> 2.1
```

### CacoaPods

```ruby
pod 'StyleSheet', :git => 'https://github.com/werediver/StyleSheet.git', :tag => 'v2.1.0'
```

Note: check the latest available version!

## License

[MIT](https://github.com/werediver/StyleSheet/blob/master/LICENSE)
