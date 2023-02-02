//
//  TabBarController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = self.tabBar.items?.firstIndex(of: item)
        let subView = tabBar.subviews[index!+1].subviews.first as! UIImageView
        self.performSpringAnimation(imgView: subView)
    }
    
    private func configureTabBar() {

        let savingVC = SavingAndAssetsController(nibName: "SavingAndAssetsController", bundle: nil)
        let savingNavVC = UINavigationController(rootViewController: savingVC)
        
        self.viewControllers = [savingNavVC]
        
        savingNavVC.tabBarItem = UITabBarItem(title: "Saving", image: UIImage(systemName: "dollarsign.arrow.circlepath"), tag: 0)
        
        self.tabBar.barTintColor = UIColor(red: 62/255, green: 64/255, blue: 77/255, alpha: 1)
        self.tabBar.tintColor = .white
       }
       
    func performSpringAnimation(imgView: UIImageView) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            imgView.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
        }
    }
    
}
