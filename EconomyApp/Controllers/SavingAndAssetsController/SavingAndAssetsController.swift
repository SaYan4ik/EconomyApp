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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
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
