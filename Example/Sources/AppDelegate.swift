import UIKit
import StyleSheet

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // `autoapply(style: <#style#>)` uses method swizzling to hook up to the view.
        // `autoapply(style: <#style#>, mode: .appearance)` uses `UIAppearance`.
        try! RootStyle.autoapply(style: appStyle(palette: DefaultPalette()))

        assert(window == nil, "Don't use `UIMainStoryboardFile`!")
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()

        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()

        return true
    }

}
