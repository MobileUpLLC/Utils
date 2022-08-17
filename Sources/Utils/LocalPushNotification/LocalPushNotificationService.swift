//
//  File.swift
//  
//
//  Created by Николай on 17.08.2022.
//

import UIKit

public protocol LocalNotificationServiceDelegate: AnyObject {

    func localNotificationService(
        _ service: LocalNotificationService,
        willPresent notification: UNNotification
    ) -> UNNotificationPresentationOptions
    
    func localNotificationService(
        _ service: LocalNotificationService,
        didReceive notification: UNNotificationResponse
    )
}

open class LocalNotificationService: NSObject, UNUserNotificationCenterDelegate {

    public weak var delegate: LocalNotificationServiceDelegate?

    open func requestAuthorization(
        options: UNAuthorizationOptions = [.alert, .sound, .badge],
        completion: @escaping (Result<Bool, Error>) -> Void
    ) { }

    open func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) { }

    open func openApplicaitonSettings() { }

    private override init() {
        super.init()
    
        UNUserNotificationCenter.current().delegate = self
    }
    
    open func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {

    }
    
    open func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
}


