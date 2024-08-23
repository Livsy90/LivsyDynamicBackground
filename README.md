# LivsyDynamicBackground

## SwiftUI dynamic background views with customizable colors.


### Lava Lamp
<img src="https://github.com/Livsy90/LivsyDynamicBackground/blob/main/LavaLampViewDemo.gif" width ="300">

### Dynamic Colors
<img src="https://github.com/Livsy90/LivsyDynamicBackground/blob/main/DynamicGradientViewDemo.gif" width ="300">

## Installation

### Swift Package Manager

```
dependencies: [
    .package(url: "https://github.com/Livsy90/LivsyDynamicBackground.git")
]
```
## Example

```swift
import SwiftUI
import LivsyDynamicBackground

// MARK: - LavaLampView

struct ContentView: View {
    
    @State private var isAnimating = false
    @State private var startColor = Color.pink
    @State private var endColor = Color.blue
    
    var body: some View {
        Text("Hello, world!")
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                LavaLampView(
                    colors: [.red, .pink, .purple, .blue]
                )
            }
    }
}

// MARK: - DynamicColorsView

struct ContentView: View {
        
    var body: some View {
        Text("Hello, world!")
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                DynamicColorsView(
                    colors: [.pink, .purple, .blue],
                    backgroundColor: .cyan
                )
            }
            .onAppear {
                isAnimating = true
            }
    }
}
```
