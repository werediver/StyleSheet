import UIKit
import StyleSheet

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        RootStyleHolder.rootStyle = appStyle(palette: DefaultPalette())
        RootStyleHolder.autoapply()

        assert(window == nil, "Don't use `UIMainStoryboardFile`!")
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()

        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()

        return true
    }

}
