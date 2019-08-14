![](https://github.com/noppefoxwolf/WarpGeometryFilter/blob/master/.github/Logo.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![](https://github.com/noppefoxwolf/WarpGeometryFilter/blob/master/.github/Preview.gif)

## Usage 

```
let filter: WarpGeometryFilter = .init(device: MTLCreateSystemDefaultDevice()!)
let source: [vector_float2] = [
vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0),
vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),
vector_float2(0, 1),   vector_float2(0.5, 1),   vector_float2(1, 1)
]

let distination: [vector_float2] = [
vector_float2(0.25, 0),   vector_float2(0.75, 0),   vector_float2(1.25, 0),
vector_float2(-0.25, 0.5), vector_float2(0.25, 0.5), vector_float2(0.75, 0.5),
vector_float2(0.25, 1),   vector_float2(0.75, 1),   vector_float2(1.25, 1)
]
let warpGeometry = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: source, destinationPositions: distination)
filter.setValue(inputImage, forKey: kCIInputImageKey)
filter.setValue(warpGeometry, forKey: kCIInputWarpGeometryKey)

let result = filter.outputImage
```

## Requirements

## Installation

WarpGeometryFilter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WarpGeometryFilter'
```

## Author

noppefoxwolf, noppelabs@gmail.com

## License

WarpGeometryFilter is available under the MIT license. See the LICENSE file for more info.
