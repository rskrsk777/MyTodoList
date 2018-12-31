//
//  AppDelegate.swift
//  MyTodoList
//  Copyright © 2018 ryosuke kubo. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var testList = ["nanami", "kamachan", "kamada", "panda"]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let navigationTodoViewController = UINavigationController(rootViewController: TodoListViewController())
        navigationTodoViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        let completedViewController = CompletedViewController()
        let navigationCompletedViewController = UINavigationController(rootViewController: completedViewController)
        navigationCompletedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        let viewControllers = [navigationTodoViewController, navigationCompletedViewController]
        let todoTabBarController = UITabBarController()
        todoTabBarController.viewControllers = viewControllers
        window?.rootViewController = todoTabBarController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

