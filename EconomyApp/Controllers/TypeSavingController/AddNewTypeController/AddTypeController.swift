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
    
    private var imagesData = ["dollarsign", "eurosign", "rublesign", "yensign", "diamond.circle", "diamond.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = 12

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }
    
    private func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    
    @IBAction func addImageOfAssetsButton(_ sender: Any) {

    }
    
    
    @IBAction func saveAssetsOrSavingButton(_ sender: Any) {
        
    }
    
}

extension AddTypeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension AddTypeController: UICollectionViewDelegate {
    
}
