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
        return allSavings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavingsCell.id, for: indexPath)
        guard let savingsCell = cell as? SavingsCell else { return cell }
        savingsCell.set(savings: allSavings[indexPath.item])
        return savingsCell
    }
    
    
}

extension SavingAndAssetsController: UICollectionViewDelegate {
    
}

extension SavingAndAssetsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let inset = 9.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        
        let width = (screen.bounds.width - (inset * (5))) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

            let edit = UIAction(title: "Edit",
                                image: UIImage(systemName: "square.and.pencil"),
                                identifier: nil,
                                discoverabilityTitle: nil, state: .off) { (_) in
                            print("edit button clicked")
                        }
            
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive,
                                  state: .off) { (_) in
                print("delete button clicked")

                RealmManager<SavingsModel>().delete(object: self.allSavings[indexPath.item])
                self.collectionView.deleteItems(at: [indexPath])
                self.allSavings = RealmManager<SavingsModel>().read()
                self.collectionView.reloadData()
                
//                RealmManager<TypeModel>().delete(object: self.typeAvalableAssets[indexPath.row])
//                self.collectionView.deleteItems(at: [indexPath])
//                self.typeAvalableAssets = RealmManager<TypeModel>().read()
//                self.collectionView.reloadData()
                
            }
            
            return UIMenu(title: "Options",
                          image: nil,
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [edit, delete])
                        
        }
        return context
    }
}

