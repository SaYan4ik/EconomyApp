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
    
    private var imagesData = ["dollarsign", "eurosign", "rublesign", "yensign", "diamond.circle", "diamond.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = 12
        self.savingImageView.tintColor = .white
        saveButton.isEnabled = false
        configureCollection()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
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
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 57/255.0, green: 121/255.0, blue: 82/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func saveAssetsOrSavingButton(_ sender: Any) {
        guard let nameType = typeOfAssetsOdSavingField.text else { return }
        guard let image = savingImageView.image else { return }        
        guard let data = image.jpegData(compressionQuality: 0.9) else { return }
        
        let type = TypeModel(type: nameType, image: data)
    }
    
}

extension AddTypeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.id, for: indexPath)
        guard let typeCell = cell as? TypeCell else { return cell }
        typeCell.set(nameImage: imagesData[indexPath.item])
        return typeCell
    }
    
}

extension AddTypeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.savingImageView.image = UIImage(systemName: imagesData[indexPath.item])
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
