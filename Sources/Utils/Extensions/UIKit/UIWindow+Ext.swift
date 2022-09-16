//
//  File.swift
//  
//
//  Created by Николай on 16.09.2022.
//

import UIKit

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
