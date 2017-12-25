import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = makeWindow()
        return true
    }

    private func makeWindow() -> UIWindow {
        let window = UIWindow()
        window.backgroundColor = .white
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        return window
    }
}
