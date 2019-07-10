//
//  AppDelegateNotification.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (_) in
            // Get notification setting
        }
    }

    func registerRemoteNofitication() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert],
                                                                    completionHandler: { (granted, _) in
                guard granted else { return }
                self.getNotificationSettings()
            })
        }
        UIApplication.shared.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UNNotificationSetting) { }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) { }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { }
}
