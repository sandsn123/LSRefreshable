# LSRefreshable
Adapt SwiftUI's Refreshable to iOS13 and iOS14

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
