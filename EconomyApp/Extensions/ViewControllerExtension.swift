//
//  ViewControllerExtension.swift
//  EconomyApp
//
//  Created by Александр Янчик on 3.02.23.
//

import Foundation
import UIKit

extension UIViewController {
    func setupNavBarBackButton() {
        let button = UIButton()
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.titleView?.tintColor = .white
       }
       
    @objc private func backAction(_ sender: Any) {
           navigationController?.popViewController(animated: true)
       }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 57/255.0, green: 121/255.0, blue: 82/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
