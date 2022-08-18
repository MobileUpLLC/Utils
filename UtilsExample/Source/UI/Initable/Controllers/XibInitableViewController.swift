//
//  XibInitableViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class XibInitableViewController: UIViewController, XibInitable {

    @IBOutlet private var serverClientLabel: UILabel!
    @IBOutlet private var gitHubImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        serverClientLabel.isHidden = true
        getJsonFormServer()
    }

    private func getJsonFormServer() {
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
    
    private func getImageFromServer(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
    
            DispatchQueue.main.async { [weak self] in
                self?.gitHubImage.image = UIImage(data: data)
                self?.serverClientLabel.isHidden = false
            }
        }
        .resume()
    }
}
