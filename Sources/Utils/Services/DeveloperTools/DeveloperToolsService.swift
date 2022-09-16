//
//  DeveloperToolsService.swift
//  Utils
//
//  Created by Petrovich on 07.11.2021.
//

import UIKit
import PulseUI

public final class DeveloperToolsService {
    
    private enum Constants {
        
        static let alertTitle = "Debug"
        static let alertMessage = "Please Select an Option"
        static let showLogActionTitle = "Show Logs"
        static let clearLogActionTitle = "Clear Logs"
        static let dismissAlertTitle = "Dismiss"
    }
    
    public static var isEnabled = false
    public static var customActions: [CustomDebugAction] = []
    
    public static func setup() {
        NotificationCenter.default.addObserver(forName: .deviceHaveBeenShaken, object: nil, queue: nil) { _ in
            showActionSheet()
            
            DeveloperToolsLogger.logMessage(
                label: "DeveloperToolsService",
                level: .event,
                message: "DeveloperToolsService was setup"
            )
        }
    }
    
    private static func showActionSheet() {
        let alert = UIAlertController(
            title: Constants.alertTitle,
            message: Constants.alertMessage,
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: Constants.showLogActionTitle, style: .default) { _ in
            openLogController()
        })
        
        alert.addAction(UIAlertAction(title: Constants.clearLogActionTitle, style: .default) { _ in
            DeveloperToolsLogger.clearLogs()
        })

        for action in customActions {
            alert.addAction(UIAlertAction(title: action.title, style: .default) { _ in
                action.handler()
            })
        }
        
        alert.addAction(UIAlertAction(title: Constants.dismissAlertTitle, style: .cancel) { _ in
            alert.dismiss(animated: true)
        })

        UIApplication.shared.windows.first?.rootViewController?.present(
            alert,
            animated: false,
            completion: nil
        )
    }
    
    private static func openLogController() {
        UIApplication.shared.windows.first?.rootViewController?.present(
            PulseUI.MainViewController(),
            animated: false,
            completion: nil
        )
    }
}

public struct CustomDebugAction {
    
    let title: String
    let handler: () -> Void
    
    public init(title: String, handler: @escaping () -> Void) {
        self.title = title
        self.handler = handler
    }
}

public extension Notification.Name {
    
    static let deviceHaveBeenShaken = Notification.Name("deviceHaveBeenShaken")
}

extension UIWindow {

    // swiftlint:disable:next override_in_extension
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if DeveloperToolsService.isEnabled && motion == .motionShake {
            DeveloperToolsLogger.logMessage(label: "Catch motion", level: .event, message: "Device have been shaken.")
            NotificationCenter.default.post(name: .deviceHaveBeenShaken, object: nil)
        } else {
            super.motionEnded(motion, with: event)
        }
    }
}
