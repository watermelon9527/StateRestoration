//
//  ViewController.swift
//  StateRestoration
//
//  Created by chijung chan  on 2023/5/8.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
    //MARK: Need to setup NSUserActivityTypes in infopilist
    var  restoredSelectedTab: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        setupTabbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(restoredSelectedTab)
        selectedIndex = restoredSelectedTab
    }
    
    func setupTabbar() {
        
        let tab1 = UIViewController()
        tab1.view.backgroundColor = UIColor.blue
        
        let tab2 = UIViewController()
        tab2.view.backgroundColor = UIColor.orange
        
        let tab3 = UIViewController()
        tab3.view.backgroundColor = UIColor.red
        
        self.setViewControllers([tab1, tab2, tab3], animated: true)
        
        let itemNames = ["1.circle","2.circle","3.circle"]
        
        let itemsTitle = [ "Page1", "Page2", "Page3"]

        guard let items = self.tabBar.items else { return }
        for (index, item) in items.enumerated(){
            item.tag = index
            item.image = UIImage(systemName: itemNames[index])
            item.title = itemsTitle[index]
        }
        
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(restoredSelectedTab)
        restoredSelectedTab = tabBarController.selectedIndex
        updateUserActivity()
    }
    
    func updateUserActivity() {
        var currentUserActivity = view.window?.windowScene?.userActivity
        
        if currentUserActivity == nil {
            currentUserActivity = NSUserActivity(activityType: SceneDelegate.MainSceneActivityType())
        }
        currentUserActivity?.addUserInfoEntries(from: [SceneDelegate.selectedTabKey: restoredSelectedTab])
        
        view.window?.windowScene?.userActivity = currentUserActivity
    }
    
}

