# Utils!

[![githubIcon-1](https://user-images.githubusercontent.com/80983073/183376152-fcdff7f9-8971-4250-90df-622f792c9ef9.png)](https://developer.apple.com/documentation/xcode-release-notes/swift-5-release-notes-for-xcode-10_2)
[![githubIcon-2](https://user-images.githubusercontent.com/80983073/183376159-db6fa792-44b5-4639-aa4c-d8c72a7ec28e.png)](https://developer.apple.com)
[![githubIcon-3](https://user-images.githubusercontent.com/80983073/183376162-1e432ab7-fe11-4c66-95a6-38c2687401d7.png)](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)
![githubIcon-2](https://user-images.githubusercontent.com/80983073/183608595-b9a19341-7914-4284-9f83-b0b84c9cc3d6.png)
[![githubIcon-4](https://user-images.githubusercontent.com/80983073/183376168-2e38a743-39ed-461d-bca1-230866f5608c.png)](https://github.com/MobileUpLLC/Utils/blob/main/LICENSE)

Some handly utilities for IOS-app development.

## Features

- Initiate view from code and xib with Initable protocols
- Find and decode json with BundleFileReader
- Handly create Local Push Notification Service with LocalNotificationService
- Use base extensions and generic closures for neat and clean code-writing
- Create reusable Xib View's to init from Xib with XibView

## Usage

### 1. Initable and XibView

Initable protocls conforms with ```UIView``` and ```UIViewController```.

1. Inherit your class from Code or Xib -Initable protocol
2. Init your class with ```.initate()```

In case you creating View from Xib, that need's to be inited in another Xib – inherit XibView class ```MyView: XibView```. XibView is also conform to XibInitable.

Initable usage example: https://github.com/MobileUpLLC/Utils/tree/develop/UtilsExample/Source/UI/Initable

XibView usage example: https://github.com/MobileUpLLC/Utils/tree/develop/UtilsExample/Source/UI/XibView

### 2. BundleFileReader

```BundleFilesReader``` and ```jsonDecoder``` allows you to conveniently decode json files from your project

```swift
func testDictionaryEncoding() {
    let dictionary: [String: Any] = ["One": 1, "Two": "Два", "Three": 0.47, "Four": true]

    do {
        let encodedData = try JSONConverter.encode(dictionary: dictionary)
        let decodedData = try JSONConverter.decode(data: encodedData) as [String: Any]

        XCTAssertEqual(
            NSDictionary(dictionary: dictionary, copyItems: false),
            NSDictionary(dictionary: decodedData, copyItems: false)
        )
    } catch {
        XCTFail()
    }
}
```

Usage example: https://github.com/MobileUpLLC/Utils/blob/develop/UtilsExample/UtilsExampleTests/UtilsExampleTests.swift

### 3. LocalNotificationService

Implement localNotificationService as singletone ```let pushService = LocalNotificationService.shared```

1. Use ```requestAuthorization``` to request User's approve for sending notifications
2. Use ```getAuthorizationStatus``` to check current authorization status
3. Use ```willPresent``` to ask the delegate what to do after receiving notification
4. Use ```didRecieve``` to inform delegate about receiving notification

An example:
```swift
@IBAction private func pushNotificationButtonTap(_ sender: UIButton) {
    pushService.getAuthorizationStatus { [weak self] status in
        if status == .authorized { 
            self?.createNotificationRequest()
            print(Constants.successAuthorizationStatus)
        } else {
            print(Constants.nonSuccessAuthorizationStatus)
        }
    }
}
```
Usage examle: https://github.com/MobileUpLLC/Utils/blob/develop/UtilsExample/Source/UI/ExampleViewController.swift

## Requirements

- Swift 5.0 +
- iOS 12.0 +

## Installation

Utils doesn't contain any external dependencies.

### CocoaPods

1. Make ```pod init``` 
2. Add the following to Podfile 

```
pod 'Utils', :git => 'https://github.com/MobileUpLLC/Utils', :tag => '0.0.23'
```

3. Make ```pod install```

### Manual

Download and drag files from Source folder into your Xcode project.

### Swift Package Manager Install

Swift Package Manager 

```
dependencies: [
    .package(url: "https://github.com/MobileUpLLC/Utils", .upToNextMajor(from: "0.0.23"))
]
```

## License

Utils is distributed under the [MIT License](https://github.com/MobileUpLLC/Utils/blob/main/LICENSE).
