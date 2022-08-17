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

public class LocalNotificationService: NSObject, UNUserNotificationCenterDelegate {

    public static let shared = LocalNotificationService()
    
    public weak var delegate: LocalNotificationServiceDelegate?

    public func requestAuthorization(
        options: UNAuthorizationOptions = [.alert, .sound, .badge],
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            completion(.success(success))
            if let error = error {
                completion(.failure(error))
            }
        }
    }

    public func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        let center = UNUserNotificationCenter.current()

        center.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }

    public override init() {
        super.init()
    
        UNUserNotificationCenter.current().delegate = self
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if let options = delegate?.localNotificationService(self, willPresent: notification) {
            completionHandler(options)
        }
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        delegate?.localNotificationService(self, didReceive: response)
        
        completionHandler()
    }
}
