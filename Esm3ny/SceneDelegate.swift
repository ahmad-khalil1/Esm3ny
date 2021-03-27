//
//  SceneDelegate.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/8/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = creatTabBarContoller()
            //UINavigationController(rootViewController: AudioBookslistVC())
        window?.makeKeyAndVisible()

    }
    
    func createAudioBookNC() -> UINavigationController {
        let audioVC =  AudioBookslistVC()
        let navController = UINavigationController(rootViewController: audioVC)
    
        audioVC.view.backgroundColor = .clear
        let tabBarItem = AKFloatTabBarItem(selectedimage: #imageLiteral(resourceName: "Books")  ,image: #imageLiteral(resourceName: "Booksblured"), tag: 0)

        audioVC.tabBarItem =  tabBarItem
        
        navController.navigationBar.prefersLargeTitles = false
        navController.isNavigationBarHidden = true
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    func creatBookMarkNC() -> UINavigationController {
        let audioVC =  UIViewController()
        let navController = UINavigationController(rootViewController: audioVC)
    
        audioVC.view.backgroundColor = .red
        let tabBarItem = AKFloatTabBarItem(selectedimage: #imageLiteral(resourceName: "Saved"), image: #imageLiteral(resourceName: "Savedblured"), tag: 1)
        audioVC.tabBarItem =  tabBarItem
        
        navController.navigationBar.prefersLargeTitles = false
        navController.isNavigationBarHidden = true
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    func createHistoryBookNC() -> UINavigationController {
        let audioVC =  UIViewController()
        let navController = UINavigationController(rootViewController: audioVC)
    
        audioVC.view.backgroundColor = .black
        let tabBarItem = AKFloatTabBarItem(selectedimage:#imageLiteral(resourceName: "Audio"), image: #imageLiteral(resourceName: "Audioblured"), tag: 2)
        audioVC.tabBarItem =  tabBarItem
        
        navController.navigationBar.prefersLargeTitles = false
        navController.isNavigationBarHidden = true
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    func createprofileNC() -> UINavigationController {
        let audioVC =  UIViewController()
        let navController = UINavigationController(rootViewController: audioVC)
    
        audioVC.view.backgroundColor = .systemGray
        let tabBarItem = AKFloatTabBarItem(selectedimage:#imageLiteral(resourceName: "Profile"), image: #imageLiteral(resourceName: "ProfileBlured"), tag: 3)
        audioVC.tabBarItem =  tabBarItem
        
        navController.navigationBar.prefersLargeTitles = false
        navController.isNavigationBarHidden = false
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    func creatTabBarContoller() -> UITabBarController {
        let tabBAr = AKFloatTabBar()
        UITabBar.appearance().tintColor = .white
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
//
//        tabBAr.tabBar.isTranslucent = true
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.2)
        UITabBar.appearance().clipsToBounds = true
        
        
        tabBAr.viewControllers = [  createAudioBookNC()  , creatBookMarkNC() , createHistoryBookNC() , createprofileNC() ]
        
        return tabBAr
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

