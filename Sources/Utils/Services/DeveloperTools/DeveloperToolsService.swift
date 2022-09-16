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
    
    public class func setup() {
        NotificationCenter.default.addObserver(forName: .deviceHaveBeenShaken, object: nil, queue: nil) { _ in
            showActionSheet()
        }
    }
    
    private class func showActionSheet() {
        let alert = UIAlertController(
            title: Constants.alertTitle,
            message: Constants.alertMessage,
            preferredStyle: .actionSheet
        )
        
        setupAlertActions(to: alert)
        
        UIApplication.shared.windows.first?.rootViewController?.present(
            alert,
            animated: false,
            completion: nil
        )
    }
    
    private class func setupAlertActions(to alert: UIAlertController) {
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
    }
    
    private class func openLogController() {
        UIApplication.shared.windows.first?.rootViewController?.present(
            PulseUI.MainViewController(),
            animated: false,
            completion: nil
        )
    }
}
