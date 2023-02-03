//
//  TypeSavingController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class TypeSavingController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var typeAvalableAssets = RealmManager<TypeModel>().read()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        getData()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
        self.collectionView.reloadData()
    }
    
    private func getData() {
        self.typeAvalableAssets = RealmManager<TypeModel>().read()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 12
        registrationCell()
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: TypeCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TypeCell.id)
    }
    
    private func setupNavBar() {
        navigationItem.title = "All type of assets or savings"
        let addButton = UIButton()
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    @objc private func addAction(_ sender: UIButton) {
        let addTypeVC = AddTypeController(nibName: "AddTypeController", bundle: nil)
        navigationController?.pushViewController(addTypeVC, animated: true)
    }
    
}


extension TypeSavingController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeAvalableAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.id, for: indexPath)
        guard let typeCell = cell as? TypeCell else { return cell }
        typeCell.set(nameImage: nil, typeModel: typeAvalableAssets[indexPath.item])
        return typeCell
    }
    
  
    
}

extension TypeSavingController: UICollectionViewDelegate {
    
}

extension TypeSavingController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 9.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        
        let width = (screen.bounds.width - (inset * (8))) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive, state: .off) { (_) in
                print("delete button clicked")
            }
            
            return UIMenu(title: "Options",
                          image: nil,
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [delete])
                        
        }
        return context
    }
}
