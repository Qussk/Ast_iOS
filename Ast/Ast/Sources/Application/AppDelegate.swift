//
//  AppDelegate.swift
//  Ast
//
//  Created by 변윤나 on 1/22/25.
//

import SwiftUI
import CoreData
import Combine
import ComposableArchitecture

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var cancellable = Set<AnyCancellable>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Ast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {
    func resetRootViewController(rootVc: UIViewController? = nil) {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = .black
//        window?.makeKeyAndVisible()

        self.window?.rootViewController = rootVc
        self.window?.makeKeyAndVisible()
    }
}
