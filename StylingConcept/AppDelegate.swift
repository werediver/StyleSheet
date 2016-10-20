import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        RootStyleHolder.rootStyle = appStyle(DefaultPalette())
        RootStyleHolder.autoapply()

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = .whiteColor()
        window!.makeKeyAndVisible()

        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()

        return true
    }

}
