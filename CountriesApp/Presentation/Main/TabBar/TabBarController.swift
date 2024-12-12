//
//  TabBarController.swift
//  CountriesApp
//
//  Created by Bakhtiyar Pirizada on 10.12.24.
//


import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()

    }
    private func configureTabBar() {
        let firstController = HomeController(viewModule: HomeViewModel())
        let secondController = QuizController()
        let thirdController = LogOutController()
        firstController.tabBarItem = UITabBarItem(title: "Home", image: UIImage (systemName: "house.fill"), tag: 0)
        secondController.tabBarItem = UITabBarItem(title: "Maps", image: UIImage (systemName: "map"), tag: 0)
        thirdController.tabBarItem = UITabBarItem(title: "Log out", image: UIImage (systemName: "rectangle.portrait.and.arrow.right"), tag: 0)
        viewControllers = [firstController,secondController,thirdController]
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .BG
        self.tabBar.barTintColor = .tabBar
    }
    
}
