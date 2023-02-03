//
//  SavingAndAssetsController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class SavingAndAssetsController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var allSavings = [SavingsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
        getData()
    }
    
    
    private func setupCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        registrationCell()
        
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: SavingsCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SavingsCell.id)
    }
    
    private func getData() {
        self.allSavings = RealmManager<SavingsModel>().read()
        self.collectionView.reloadData()
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

extension SavingAndAssetsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension SavingAndAssetsController: UICollectionViewDelegate {
    
}


