# Utils

<p align="left">
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-Swift_5-green" alt="Swift5" /></a>
 <img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
 <a href="https://github.com/MobileUpLLC/Utils/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green" alt="License: MIT" /></a>
<img src="https://img.shields.io/badge/SPM-compatible-green" alt="SPM Compatible">
<img src="https://img.shields.io/badge/CocoaPods-compatible-green" alt="Cocoapods Compatible">
</p>

Utils for iOS development.

## Features

- [Initable](#initable)
- [BundleFileReader](#bundlefilereader)
- [LocalNotificaitonService](#localnotificationservice)
- [Extensions](#extensions)
- [MulticastDelegate](#multicastdelegate)
- [ServerClient](/Documentation/ServerClient.md)
- [Button](#button)
- [Layout](#layout)

### Initable
Initialize views/controllers from code/xib/storyboard with one simple interface ```.initiate()```

Controllers example:
```swift
// Controller without nib.
class FooController: UIViewController, CodeInitable { }
let foo = FooController.initiate()

// Controller with xib named "FooContoller"
class BarController: UIVewController: XibInitable {
    static var xibName: String { "FooContoller" }
}
let bar = BarController.initiate()

// Controller with storyboard named "BazStoryboard" with id "BazControllerId"
class BazController: UIVewController: StoryboardInitable {
    static var storyboardId: String { "BazControllerId" }
    static var storyboardName: String { "BazStoryboard" }
}
let baz = BazController.initiate()
```

[Initable Example](https://github.com/MobileUpLLC/Utils/tree/develop/UtilsExample/Source/UI/Initable)


### BundleFileReader
Reading custom object/JSON/Data from Bundle.

Bundle contains ```foo.json``` file.
```json
{
    "bar": 100
}
```

Reading:
```swift
struct Foo {
    let bar: Int
}

let foo: Foo = BundleFileReader.readObject("foo")
```

More about BundleFileReader in action [here](https://github.com/MobileUpLLC/Utils/blob/develop/UtilsExample/UtilsExampleTests/UtilsExampleTests.swift).

### LocalNotificationService

Lightweight tool for managing local notifications. Tools:
1. Use ```requestAuthorization``` to request User's approve for sending notifications
2. Use ```getAuthorizationStatus``` to check current authorization status
3. Use ```willPresent``` to ask the delegate what to do after receiving notification
4. Use ```didRecieve``` to inform delegate about receiving notification

Example:
```swift
LocalNotificationService.shared.getAuthorizationStatus { status in
    if status == .authorized { 
        // Do some...
    } else {
        // Do another...
    }
}
```
[LocalNotificationService examle](https://github.com/MobileUpLLC/Utils/blob/develop/UtilsExample/Source/UI/ExampleViewController.swift)


### Extensions

Useful extensions for all code situations
```swift
let number = Float.two // 2.0
let closure = Closure.Int // (Int) -> Void
let color = UIColor(hex: "#FFFFFF") // White Color
// and others
```

[Extensions example](https://github.com/MobileUpLLC/Utils/tree/develop/Sources/Utils/Extensions)


### MulticastDelegate

MulticastDelegate hepls to manage more than one delegate.
```swift
protocol FooDelegate: AnyObject { 
    func bar()
 }

let multicastDelegate = MulticastDelegate<FooDelegate>()

multicastDelegate.add(delegate: object)
multicastDelegate.remove(delegate: object)

multicastDelegate.invokeForEachDelegate { delegate in
    delegate.bar()
}
```

### UIKit.View(Controller) Preview
Live preview for UIKit views/controllers.

```swift
class FooView: UIView { ... }

struct FooView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            FooView()
        }
    }
}
```

### Button
Base button class with a lots of customization.

Usage from code:
```swift 
class FooButton: Button { }
```

Usage from nib:
1. Set your button class to ```Button``` in IB
1. Set Type = Custom in IB
2. Set Style = [Default](https://stackoverflow.com/questions/71137424/custom-uibutton-imageedgeinsets-titleedgeinsets-not-working) in IB

### Layout
Simple view layout

```swift
let superview = UIView()
let subview = UIView()

superview.layoutSubview(subview, with: LayoutInsets.zero, safe: true)
```

## Requirements

- Swift 5.0 +
- iOS 12.0 +

## Installation

Utils contain Alamofire 5.6 as external dependencies.

### CocoaPods

1. Make ```pod init``` 
2. Add the following to Podfile 

```
pod 'Utils', :git => 'https://github.com/MobileUpLLC/Utils', :tag => '0.0.43', :branch => 'develop'
```

3. Make ```pod install```

### Manual

Download and drag files from Source folder into your Xcode project.

### Swift Package Manager Install

Swift Package Manager 

```
dependencies: [
    .package(url: "https://github.com/MobileUpLLC/Utils", .upToNextMajor(from: "0.0.43"))
]
```

## License

Utils is distributed under the [MIT License](https://github.com/MobileUpLLC/Utils/blob/main/LICENSE).
