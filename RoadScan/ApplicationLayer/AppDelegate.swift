import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCDM2tOxkbG3s2FifKxEZPwSIMSUZveaT8")
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        checkForFirstLaunching()
        
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
}
