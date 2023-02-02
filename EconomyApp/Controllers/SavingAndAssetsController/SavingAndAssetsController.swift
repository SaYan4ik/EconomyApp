//
//  SavingAndAssetsController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class SavingAndAssetsController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
//    RealmManager<HistoryRealmModel>().read()
//    let request = HistoryRealmModel(date: Date.now, statusCode: response.statusCode, requestHist: requestType)
//    RealmManager<HistoryRealmModel>().write(object: request)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 57/255.0, green: 121/255.0, blue: 82/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupNavBar() {
        let addButton = UIButton()
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    @objc private func addAction(_ sender: UIButton) {
        let addVC = AddController(nibName: "AddController", bundle: nil)
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    
}
