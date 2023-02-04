//
//  AddController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class AddController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var savingsAmountField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var typeImageView: UIImageView!
    
    private var allTypeSavings = [TypeModel]()
    private var selectedIndex = IndexPath(row: 0, section: 0)
    private var existSaving: SavingsModel?
    private var typeController: TypeControllerEnum = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checExistSave()
        getData()
        self.setupNavBarBackButton()
        setupCollection()
        self.title = "Add new savings"
        self.container.layer.cornerRadius = 12
        self.saveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
    }

    
    @IBAction func saveButtondidTap(_ sender: Any) {
        guard !savingsAmountField.text.isEmptyOrNil else { return }
        
        switch typeController {
            case .create:
                let savings = SavingsModel(
                    currency: savingsAmountField.text!,
                    typeValue: allTypeSavings[selectedIndex.row]
                )
                
                RealmManager<SavingsModel>().write(object: savings)
            case .edit:
                guard let existSaving else { return }
                RealmManager<SavingsModel>().update { [weak self] realm in
                    guard let self else { return }
                    
                    try? realm.write {
                        existSaving.currency = self.savingsAmountField.text!
                        existSaving.typeValue = self.allTypeSavings[self.selectedIndex.row]
                    }
                }
                navigationController?.popViewController(animated: true)
        }
        
        
        
       
    }
    
    private func setupCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.layer.cornerRadius = 12
        registrationCell()
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: TypeCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TypeCell.id)
    }
    
    
    private func getData() {
        self.allTypeSavings = RealmManager<TypeModel>().read()
        self.collectionView.reloadData()
    }
    
    private func checExistSave() {
        guard existSaving != nil,
              typeController == .edit
        else { return }
        setupData()
    }
    
    func set(savings: SavingsModel, type: TypeControllerEnum) {
        self.existSaving = savings
        self.typeController = type
    }
    
    private func setupData() {
        guard let existSaving else { return }
        self.savingsAmountField.text = existSaving.currency
        guard let imageNew = existSaving.typeValue?.image else { return }
        guard let image : UIImage = UIImage(data: imageNew)?.withRenderingMode(.alwaysTemplate) else { return }
        self.typeImageView.image = image
    }
    
    
}

extension AddController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTypeSavings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.id, for: indexPath)
        guard let typeCell = cell as? TypeCell else { return cell }
        typeCell.set(nameImage: nil, typeModel: allTypeSavings[indexPath.item])
        return typeCell
    }
    
    
}

extension AddController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageNew = allTypeSavings[indexPath.item].image,
              let image : UIImage = UIImage(data: imageNew)?.withRenderingMode(.alwaysTemplate)
        else { return }
        self.selectedIndex = indexPath
        print(self.selectedIndex)
        
        self.typeImageView.image = image
        self.saveButton.isEnabled = true
    }
}

extension AddController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 9.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        
        let width = (screen.bounds.width - (inset * (8))) / 3
        return CGSize(width: width, height: width)
    }
}
