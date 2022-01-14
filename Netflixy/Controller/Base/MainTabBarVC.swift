//
//  ViewController.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 04/01/2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
    //MARK: - Helper Function
    
    func setUpTabbar(){
        let homeVC = UINavigationController(rootViewController: HomeVC())
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.title = "Home"
        
        let searchVC = UINavigationController(rootViewController: SearchVC())
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchVC.title = "Top search"
        
        let upcomingVC = UINavigationController(rootViewController: UpcomingVC())
        upcomingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        upcomingVC.title = "Up coming"
        
        let downloadVC = UINavigationController(rootViewController: DownloadsVC())
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        downloadVC.title = "Downloading"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeVC,upcomingVC,searchVC,downloadVC], animated: true)
    }


}

