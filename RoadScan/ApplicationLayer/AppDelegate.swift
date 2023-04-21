import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCDM2tOxkbG3s2FifKxEZPwSIMSUZveaT8")
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        checkForFirstLaunching()
        
        setupNotifications(application)
        
        return true
    }
}

extension AppDelegate {
    func checkForFirstLaunching() {
        var navigationController: UINavigationController?
        
        if UserDefaults.standard.bool(forKey: "isOnboardingDone") == true {
            navigationController = UINavigationController(rootViewController: MainTabBarController())
        } else {
            navigationController = UINavigationController(rootViewController: OnBoardingViewController())
            
            UserDefaults.standard.set(true, forKey: "isOnboardingDone")
        }
        
        window?.rootViewController = navigationController
    }
    
    private func setupNotifications(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in
            print(#function)
        }
        application.registerForRemoteNotifications()
    }
}

extension AppDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        let _ = notification.request.content.userInfo
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
