# Server Client

HTTP Networking service based on Alamofire

## Usage

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
    ```
        
## AsyncServerClient

Classic ServerClients's twin, which implement the same functionality by using async/await. Allows to chain requests with single error handling. Result of every chained request can be used in further ones. Can be also used in syncronous functions by creating a Task unit.

```swift
    private func getJsonWithAsyncServerClient() {
        getData { [weak self] in
            let entity = try await ExampleAsyncServerClient.shared.performRequest(
                method: .get,
                type: MessageEntity.self,
                endpoint: Constants.apiEndpoint
            )
            
            self?.getImageFromServer(with: entity.message)
        }
    }
```
    
```swift   
    func getData(_ request: @escaping (() async throws -> Void)) {
        Task {
            do {
                try await request()
            } catch let error as ServerError {
                print(error.localizedDescription)
            }
        }
    }
```
