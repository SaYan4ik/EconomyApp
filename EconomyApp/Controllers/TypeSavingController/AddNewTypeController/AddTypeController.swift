//
//  AddTypeController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class AddTypeController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var typeOfAssetsOdSavingField: UITextField!
    @IBOutlet weak var savingImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    
    private var imagesData = ["Dollar", "Euro", "Ruble", "Peso", "Bitcoin", "Swiss franc", "Metal", "Gem"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = 12
        self.savingImageView.tintColor = .white
        saveButton.isEnabled = false
        configureCollection()
        self.setupNavBarBackButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
        self.collectionView.reloadData()
    }

    @IBAction func saveAssetsOrSavingButton(_ sender: Any) {
        guard let nameType = typeOfAssetsOdSavingField.text else { return }
        guard let image = savingImageView.image else { return }        
        guard let data = image.pngData() else { return }
        
        let type = TypeModel(type: nameType, image: data)
        RealmManager<TypeModel>().write(object: type)
    }
    
    private func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 12
        registrationCell()
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: TypeCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TypeCell.id)
    }
    
}

extension AddTypeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.id, for: indexPath)
        guard let typeCell = cell as? TypeCell else { return cell }
        typeCell.set(nameImage: imagesData[indexPath.item], typeModel: nil)
        return typeCell
    }
    
}

extension AddTypeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.savingImageView.image = UIImage(named: imagesData[indexPath.item])
        self.saveButton.isEnabled = true
        
    }
}

extension AddTypeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 9.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        
        let width = (screen.bounds.width - (inset * (8))) / 3
        return CGSize(width: width, height: width)
    }
}
