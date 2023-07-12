//
//  File.swift
//  
//
//  Created by Николай on 17.08.2022.
//

import UIKit

extension UNAuthorizationOptions {
    public static var `default`: UNAuthorizationOptions { [.alert, .sound, .badge] }
}

extension UNNotificationPresentationOptions {
    public static var `default`: UNNotificationPresentationOptions {
        if #available(iOS 14.0, *) {
            return [.banner, .list, .sound, .badge]
        } else {
            return [.alert, .sound, .badge]
        }
    }
}

extension UNAuthorizationStatus {
    public var isDenied: Bool { self == .denied }
    public var isNotDetermined: Bool { self == .notDetermined }
    public var isAuthorized: Bool { self == .authorized }
}

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

extension LocalNotificationServiceDelegate {
    public func localNotificationService(
        _ service: LocalNotificationService,
        willPresent notification: UNNotification
    ) -> UNNotificationPresentationOptions {
        .default
    }
}

public class LocalNotificationService: NSObject, UNUserNotificationCenterDelegate {
    public static let shared = LocalNotificationService()
    
    public weak var delegate: LocalNotificationServiceDelegate?

    public var authorizationStatus: UNAuthorizationStatus {
        get async {
            await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
        }
    }
    
    public func requestAuthorization(options: UNAuthorizationOptions = .default) async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(options: options)
    }
    
    public func requestAuthorization(
        options: UNAuthorizationOptions = .default,
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

    private override init() {
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
