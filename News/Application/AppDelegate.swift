//
//  AppDelegate.swift
//  News
//
//  Created by Ivan Depolo on 29/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    fileprivate struct Constants{
        static let baseUrl = "BASE_URL"
        static let baseUrlErrorMsg = "Error fetching baseURL"
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard
            let info = Bundle.main.infoDictionary,
            let baseURL = info[Constants.baseUrl] as? String else {
            fatalError(Constants.baseUrlErrorMsg)
        }
        
        NewsManager.shared.configure(with: APIConnector(with: baseURL) )
        
        // for a lager viewcontroller count it might be more appropriate to use a coordinator pattern
        // the setup of to the baseUr would appear int the rootNavigationCoordinator
        //let navigationCoordinator = NavigationCoordinator( rootViewController: UINavigationController() )
        //window?.rootViewController = navigationCoordinator.rootViewController
    
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVM = MainVM( newsManager: NewsManager.shared )
        let mainVC = MainVC( viewModel: mainVM )
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
        
        return true
    }


}

