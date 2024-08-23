# LivsyDynamicBackground

## SwiftUI dynamic background views with customizable colors.

<img src="https://github.com/Livsy90/LivsyDynamicBackground/blob/main/LavaLampViewDemo.gif" width ="300">
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

struct ContentView: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LavaLampView(
                isAnimating: $isAnimating,
                startColor: .constant(.red),
                endColor: .constant(.purple)
            )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct ContentView: View {
        
    var body: some View {
        Text("Hello, world!")
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                DynamicGradientView(
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
