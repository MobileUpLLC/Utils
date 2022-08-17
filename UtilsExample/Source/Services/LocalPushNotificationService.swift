//
//  LocalPushNotificationService.swift
//  UtilsExample
//
//  Created by Николай on 17.08.2022.
//

import UIKit
import Utils

final class LocalPushNotificationService: LocalNotificationService {

    static let shared = LocalPushNotificationService()
    
    override private init() {
        super.init()
    }

    override func requestAuthorization(
        options: UNAuthorizationOptions = [.alert, .sound, .badge],
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        super.requestAuthorization(options: options, completion: completion)
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if success {
                completion(.success(true))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    override func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        super.getAuthorizationStatus(completion: completion)
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
    
    override func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions
        ) -> Void) {
        super.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
        
        print("Screen was not locked")
    }
}
