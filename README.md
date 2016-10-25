[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-blue.svg)](https://swift.org/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-brightgreen.svg)](https://cocoapods.org/)

An approach to define composable UI styles.

Having some base styles defined you can use them like so:

```swift
import UIKit

class ViewController: UIViewController {}

final class TitleLabel: UILabel, TitleFontStyle {}
final class BodyLabel: UILabel, BodyFontStyle, MultilineLabelStyle {}
final class CaptionLabel: UILabel, CaptionFontStyle, MultilineLabelStyle {}
```

See [`Style.swift`](https://github.com/werediver/StyleSheet/blob/master/Sources/Style.swift) and [`RootStyle.swift`](https://github.com/werediver/StyleSheet/blob/master/Sources/RootStyle.swift) for implementation details.