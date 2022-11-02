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
- Work with network connection with ServerClient

## Usage

### 1. Initable and XibView

Initable protocls conforms with ```UIView``` and ```UIViewController```.

1. Inherit your class from Code or Xib -Initable protocol
2. Init your class with ```.initate()```

In case you creating View from Xib, that need's to be inited in another Xib – inherit XibView class ```MyView: XibView```. XibView is also conform to XibInitable.

[Initable usage example](https://github.com/MobileUpLLC/Utils/tree/develop/UtilsExample/Source/UI/Initable)

[XibView usage example](https://github.com/MobileUpLLC/Utils/tree/develop/UtilsExample/Source/UI/XibView)

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

[BundleFileReader usage example](https://github.com/MobileUpLLC/Utils/blob/develop/UtilsExample/UtilsExampleTests/UtilsExampleTests.swift)

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
[LocalNotificationService usage examle](https://github.com/MobileUpLLC/Utils/blob/develop/UtilsExample/Source/UI/ExampleViewController.swift)

### 4. ServerClient

Idea of the Client is a One Server, one Error type, many Data types. Handly way to create client-server application.

1. Implement your own ```ServerClient``` singletone inherited from ```HttpClient``` with custom Error handler
2. Override ```init(baseUrl: String)``` with calling ```init(baseUrl, session)```

In [Example](https://github.com/MobileUpLLC/Utils/blob/task/UPUP-223-server-client/UtilsExample/Source/Service/ExampleServerClient.swift) we will connect to random dog image API

```swift
enum ServerError: Error {
    
    case pageNotFound
    case unacceptableStatusCode(Int)
    case unknown
}

class ExampleServerClient: HttpClient<ServerError> {
    
    static let shared = ExampleServerClient(baseUrl: "https://dog.ceo/")
    
    convenience init(baseUrl: String) {
        self.init(baseUrl: baseUrl, session: Session(DataRequestLogger()))
    }
}
```

3. Override ```convertError``` to handle custom server errros

```swift
override class func convertError(_ error: AFError) -> ServerError {
    print("\(error)")

    if error.responseCode == 404 {
        return .pageNotFound
    } else {
        return .unknown
    }
}
```

4. Override ```valildateResponse``` to validate incoming response

```swift
override class func validateResponse(
    request: URLRequest?,
    response: HTTPURLResponse,
    data: Data?
) -> Result<Void, ServerError> {
    if (200..<300).contains(response.statusCode) {
        return .success(Void())
    } else {
        return .failure(ServerError.unacceptableStatusCode(response.statusCode))
    }
}
```

5. Override get and post method's as you want to perform request

You can see all the code in [Example file](https://github.com/MobileUpLLC/Utils/blob/task/UPUP-223-server-client/UtilsExample/Source/Service/ExampleServerClient.swift)

```swift
    @discardableResult
    override func get<T: Decodable>(
        type: T.Type,
        endpoint: String,
        parameters: [String: Any]? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, ServerError>) -> Void
    ) -> DataRequest {
        return
            performRequest(
                method: .get,
                type: type,
                endpoint: endpoint,
                parameters: parameters,
                decoder: decoder,
                completion: completion
            )
    }
```

6. Create Entity to decode incoming JSON's

```swift
struct ExampleEntity: Decodable {
    
    var message: String?
}
```

7. Bring written code to life

```swift
func getJsonFormServer() {
    ExampleServerClient.shared.get(
        type: ExampleEntity.self,
        endpoint: "api/breeds/image/random"
    ) { result in
        switch result {
        case .success(let entity):
            if let url = entity.message {
                self.getImageFromServer(with: url)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
```

8. You can also make your own DataRequestLogger 
    1. Create ```class ExampleLogger: DataRequestLogger```
    2. Override ```printLogs()``` with your Log framework
    ```swift
    final class RequestLogger: DataRequestLogger {

        override func printLogs(_ logs: String) {
            Log.details(logs)
        }
    }
    ```
    3. Then push your logger in ```ServerClient``` Init

    ```swift    
    convenience init(baseUrl: String) {
        self.init(baseUrl: baseUrl, session: Session(RequestLogger()))
        
### 5. AsyncServerClient

Classic ServerClients's twin, which implement the same functionality by using async/await. Allows to chain requests with single error handling. Result of every chained request can be used in further ones. Can be also used in syncronous functions by creating a Task unit.

    ```swift
    private func getJsonFromServer() {
        Task {
            do {
                let entity = try await ExampleAsyncServerClient.shared.performRequest(
                    method: .get,
                    type: MessageEntity.self,
                    endpoint: "api/breeds/image/random"
                )
                print("Success: \(String(describing: entity.message))")
            } catch let error as ServerError {
                print(error.localizedDescription)
            }
        }
    }
    ```

### 6. Extensions

[UIKit and Foundation extensions](https://github.com/MobileUpLLC/Utils/tree/develop/Sources/Utils/Extensions)

Extensions for numbers (Int, Double, Float, CGFloat)
```swift
        let red = Float(components[.zero])
        let green = Float(components[.one])
        let blue = Float(components[.two])
        var alpha: Float = .one
```

Added a convenient layout for view
```swift
        let superview = UIView()
        let subview = UIView()
        superview.layoutSubview(subview, with: LayoutInsets.zero, safe: true)
```

Added hex value for UIColor
```swift
    let hexFromGreen: String = UIColor.green.hexValue
    
    let colorFromHex: UIColor = .init(hex: "#34eb49")
```

### 7. Button

Added a basic button that you can work with and xib. Just inherit your button from the ```Button``` class in the inspector.
To use the button, you need to set:
1. Type = Custom
2. Style = [Default](https://stackoverflow.com/questions/71137424/custom-uibutton-imageedgeinsets-titleedgeinsets-not-working)

More about [UIEdgeInsets](https://medium.com/short-swift-stories/using-uiedgeinsets-to-layout-a-uibutton-44ba04dd085c)


![Example](https://github.com/MobileUpLLC/Utils/blob/task/Add-documentation-for-Button/UtilsExample/Source/App/Resources/ButtonExample.png)

## Requirements

- Swift 5.0 +
- iOS 12.0 +

## Installation

Utils contain Alamofire 5.6 as external dependencies.

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
