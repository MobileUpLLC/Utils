//
//  DeveloperToolsService.swift
//  Utils
//
//  Created by Petrovich on 07.11.2021.
//

import UIKit

public final class DeveloperToolsService {
    
    public static var isEnabled = false
    static weak var customActionDelegate: DeveloperToolsCustomActionDelegate?
    
    public static func setup() {
        NotificationCenter.default.addObserver(forName: .deviceHaveBeenShaken, object: nil, queue: nil) { _ in
            
            let toolsController = DeveloperToolsController.init(nibName: "DeveloperToolsController", bundle: Bundle.module)
            toolsController.modalPresentationStyle = .overCurrentContext
            
            UIApplication.shared.windows.first?.rootViewController?.present(
                toolsController,
                animated: false,
                completion: nil
            )
        }
    }
}

public extension Notification.Name {
    
    static let deviceHaveBeenShaken = Notification.Name("deviceHaveBeenShaken")
}

extension UIWindow {

    // swiftlint:disable:next override_in_extension
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if DeveloperToolsService.isEnabled && motion == .motionShake {
            print("Device have been shaken.")
            NotificationCenter.default.post(name: .deviceHaveBeenShaken, object: nil)
        } else {
            super.motionEnded(motion, with: event)
        }
    }
}
