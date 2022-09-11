//
//  AppDelegate.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import IQKeyboardManagerSwift
import SwiftyUserDefaults
import DropDown
import ToastSwiftFramework
//com.sample.AQMS
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //Initializing Firebase push notifications.
        initializeFirebasePushNotifications(application: application)
        // Set Keyboard appearance
        IQKeyboardManager.shared.enable = true
        ToastManager.shared.position = .top
        ToastManager.shared.style.backgroundColor = UIColor(red: 237/255.0, green: 107/255.0, blue: 73/255.0, alpha: 1.0)
        setUpDropDown()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func initializeFirebasePushNotifications(application: UIApplication) {
        // Use Firebase library to configure APIs
        //FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        //application.applicationIconBadgeNumber = 0
        //UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        Defaults.fcmToken = fcmToken ?? ""
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        let identifier = notification.request.identifier
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            let aps = ((userInfo["aps"] as! [String: Any])["alert"] as! [String: Any])["body"] as! String
            let aps_title = ((userInfo["aps"] as! [String: Any])["alert"] as! [String: Any])["title"] as! String
            
        }
        
        // Print full message.
        print(userInfo)
        
        let badgeCount = 1
        print("NOTIFICATIONS COUNT will Present: 1")
        if badgeCount > 0 {
            //let storedCount = userDefaults.integer(forKey: "notificationCount")
           // userDefaults.setValue(storedCount + badgeCount, forKey: "notificationCount")
            //userDefaults.synchronize()
        }
        postNotificationUpdate()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        //UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        // Change this to your preferred presentation option
        completionHandler([[.alert, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let identifier = response.notification.request.identifier
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            let aps = ((userInfo["aps"] as! [String: Any])["alert"] as! [String: Any])["body"] as! String
            let aps_title = ((userInfo["aps"] as! [String: Any])["alert"] as! [String: Any])["title"] as! String

            
        }
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        let badgeCount = UIApplication.shared.applicationIconBadgeNumber
        print("NOTIFICATIONS COUNT 2: \(badgeCount)")
        if badgeCount > 0 {
            //let storedCount = userDefaults.integer(forKey: "notificationCount")
            //userDefaults.setValue(storedCount + badgeCount, forKey: "notificationCount")
            //userDefaults.synchronize()
        }
        postNotificationUpdate()
        
       // UIApplication.shared.applicationIconBadgeNumber = 0
        //UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
    
    func postNotificationUpdate() {
        NotificationCenter.default
                    .post(name:           NSNotification.Name("com.notification.count.update"),
                     object: nil,
                     userInfo: nil)
    }
}

extension AppDelegate  {
    //MARK: Drop Down library Initialization
    /// Drop Down library intializations.
    func setUpDropDown() {
        DropDown.startListeningToKeyboard()
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 16.0)
        DropDown.appearance().backgroundColor = .white
        DropDown.appearance().selectionBackgroundColor = .white
        DropDown.appearance().cellHeight = 45
    }
}
