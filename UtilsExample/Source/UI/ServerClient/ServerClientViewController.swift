//
//  ServerClientViewController.swift
//  UtilsExample
//
//  Created by Denis Sushkov on 10.11.2022.
//

import UIKit
import Utils

final class ServerClientViewController: UIViewController, XibInitable {
    private enum Constants {
        static let apiEndpoint = "api/breeds/image/random"
    }
    
    @IBOutlet private var asyncImageView: UIImageView!
    
    private func getJsonWithServerClient() {
        ExampleServerClient.shared.get(
            type: MessageEntity.self,
            endpoint: Constants.apiEndpoint
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
    
    func getData(_ request: @escaping (() async throws -> Void)) {
        Task {
            do {
                try await request()
            } catch let error as ServerError {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getImageFromServer(with urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
    
            DispatchQueue.main.async {
                self?.asyncImageView.image = UIImage(data: data)
            }
        }
        .resume()
    }
    
    @IBAction private func getImageWithServerClientButtonTapped() {
        getJsonWithServerClient()
    }
    
    @IBAction private func getImageWithAsyncServerClientButtonTapped() {
        getJsonWithAsyncServerClient()
    }
}
