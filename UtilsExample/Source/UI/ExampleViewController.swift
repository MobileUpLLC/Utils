//
//  ExampleViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class ExampleViewController: UIViewController {
    private enum Constants {
        static let successAuthorization = "Success"
        static let nonSuccessAuthorization = "Failure"
        static let successAuthorizationStatus = "Lock screen to get Notification"
        static let nonSuccessAuthorizationStatus = "Has no rules to push Notifications"
        static let notificationTitle = "Feed the cat"
        static let notificationSubtitle = "It looks hungry"
        static let notificationDelay: TimeInterval = 5
    }
    
    @IBOutlet private var closureTextFieldResultLabel: UILabel!
    @IBOutlet private var closureSliderResultLabel: UILabel!
    
    private let pushService = LocalNotificationService.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        Task {
            do {
                let isAuthorized = try await LocalNotificationService.shared.requestAuthorization()
                
                if isAuthorized {
                    print(Constants.successAuthorization)
                } else {
                    print(Constants.nonSuccessAuthorization)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    @IBAction private func openStoryboardInitableControllerButtonTapped() {
        let storyboardController = StoryboardInitableController.initiate()
        
        navigationController?.pushViewController(storyboardController, animated: true)
    }

    @IBAction private func openXibInitableTap() {
        let xibController = XibInitableViewController.initiate()

        navigationController?.pushViewController(xibController, animated: true)
    }

    @IBAction private func openCodeInitableControllerTap() {
        let codeController = CodeInitableViewController.initiate()
    
        navigationController?.pushViewController(codeController, animated: true)
    }
    
    @IBAction private func openClosureControllerTap(_ sender: UIButton) {
        let xibContoller = ClosureExampleViewController.initiate()
        
        xibContoller.textFieldClosure = { [weak self] result in
            self?.closureTextFieldResultLabel.text = result
        }
        xibContoller.sliderClosure = { [weak self] result in
            self?.closureSliderResultLabel.text = String(result)
        }
        
        navigationController?.pushViewController(xibContoller, animated: true)
    }
    
    @IBAction private func openMulticastDelegateExampleButtonTapped() {
        let multicastDelegateController = MulticastDelegateController.initiate()
        
        navigationController?.pushViewController(multicastDelegateController, animated: true)
    }
    
    @IBAction private func pushNotificationButtonTap(_ sender: UIButton) {
        Task {
            let status = await LocalNotificationService.shared.authorizationStatus
            if status.isAuthorized {
                createNotificationRequest()
                print(Constants.successAuthorizationStatus)
            } else {
                print(Constants.nonSuccessAuthorizationStatus)
            }
        }
    }

   @IBAction private func openXibViewTap() {
        let controller = XibViewViewControllerExample.initiate()
        
        navigationController?.pushViewController(controller, animated: true)
    }

    private func createNotificationRequest() {
        let content = UNMutableNotificationContent()
        content.title = Constants.notificationTitle
        content.subtitle = Constants.notificationSubtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Constants.notificationDelay, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
