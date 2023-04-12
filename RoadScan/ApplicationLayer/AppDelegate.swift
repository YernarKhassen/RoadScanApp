import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCDM2tOxkbG3s2FifKxEZPwSIMSUZveaT8")
        
        let navigationController = UINavigationController(rootViewController: MainTabBarController())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

