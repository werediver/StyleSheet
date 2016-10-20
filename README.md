An approach to define composable UI styles.

Having some base styles defined you can use them like so:

```swift
import UIKit

class ViewController: UIViewController {}

final class TitleLabel: UILabel, TitleFontStyle {}
final class BodyLabel: UILabel, BodyFontStyle, MultilineLabelStyle {}
final class CaptionLabel: UILabel, CaptionFontStyle, MultilineLabelStyle {}
```

See [`Style.swift`](https://github.com/werediver/StyleSheet/blob/master/StylingConcept/Style.swift) and [`RootStyle.swift`](https://github.com/werediver/StyleSheet/blob/master/StylingConcept/RootStyle.swift) for implementation details.