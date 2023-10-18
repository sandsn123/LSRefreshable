# LSRefreshable
Adapt SwiftUI's Refreshable to iOS13 and iOS14

## Requirements
- Xcode 12.x
- Swift 5.x


## Installation

### [Swift Package Manager (SPM)](https://github.com/sandsn123/LSRefreshable.git#swift-package-manager-spm)

1. File -> Swift Packages -> Add Package Dependency...
2. Enter package URL :https://github.com/sandsn123/LSRefreshable.git, choose the latest release

## Expamle:

```swift
  ScrollView {
      ForEach(0..<array.count, id: \.self) { index in
          let text = array[index]
          HStack {
             Text(text)
          }
      }
 }
 .makeRefreshable {
      try? await Task.sleep(nanoseconds: 2_000_000_000)
 }
```

![](https://media.giphy.com/media/43XHYbWpMmGePHVmpu/giphy.gif)
