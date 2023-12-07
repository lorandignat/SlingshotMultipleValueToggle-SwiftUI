# SlingshotMultipleValueToggle
A custom SwiftUI toggle that allows multiple values, it's customizable, and has a neat slingshot animation when sliding the selector.

![Showcase](https://github.com/lorandignat/SlingshotMultipleValueToggle-SwiftUI/blob/main/Showcase/showcase.gif)

## Requirements

- iOS 14.0+
- Swift 5.0+

## Installation

### Swift Package Manager

To install
it, follow the steps:

```script
Open Xcode project > File > Swift Packages > Add Package Dependecy
```

After that, put the url in the field: `https://github.com/lorandignat/SlingshotMultipleValueToggle-SwiftUI.git`

## How to use

Import library in your file:

```Swift
import SlingshotMultipleValueToggle
```

Create a state variable to keep track of the selected value:

```Swift
@State var selectedValue: UInt = 0
```

Basic functionality using default values:

```Swift
SlingshotMultipleValueToggle(selectedValue: $selectedValue)
.frame(width: 250, height: 40)
```

Customized view:

```Swift
SlingshotMultipleValueToggle(selectedValue: $selectedValueTwo,
                             backgroundColor: .orange.opacity(0.5),
                             backgrondShadowRadius: 0,
                             icons: [Image(systemName: "figure.wave.circle"),
                                     Image(systemName: "figure.walk.circle"),
                                     Image(systemName: "figure.run.circle")],
                             iconSelectedColor: .red,
                             iconDefaultColor: .red,
                             selectionFillColor: .mint
)
.frame(width: 250, height: 40)
```

## Communication

- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request.
