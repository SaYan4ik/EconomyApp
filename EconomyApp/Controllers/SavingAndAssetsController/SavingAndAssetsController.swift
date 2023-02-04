//
//  SavingAndAssetsController.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class SavingAndAssetsController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!
    
    private var allSavings = [SavingsModel]()
    
    private var currentSelectedIndex = 0 {
        didSet {
            updateSelectedCardIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollection()
        showIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
        getData()
        showIndicatorView()
    }
    
    
    private func setupCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.collectionViewLayout = CellCollectionFlowLayout()
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
    
    private func showIndicatorView() {
            
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<allSavings.count {
            let dot = UIImageView(image: UIImage(systemName: "circle.fill"))
            
            dot.heightAnchor.constraint(equalToConstant: 10).isActive = true
            dot.widthAnchor.constraint(equalToConstant: 10).isActive = true
            dot.image = dot.image!.withRenderingMode(.alwaysTemplate)
            dot.tintColor = UIColor.lightGray
            dot.tag = index + 1
            
            if index == currentSelectedIndex {
                dot.tintColor = UIColor.white
            }
            stackView.addArrangedSubview(dot)
        }
        
        indicatorView.subviews.forEach({ $0.removeFromSuperview() })
        indicatorView.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor).isActive = true
    }
    
    private func updateSelectedCardIndicator() {
           for index in 0...allSavings.count - 1 {
               let selectedIndicator: UIImageView? = indicatorView.viewWithTag(index + 1) as? UIImageView
               selectedIndicator?.tintColor = index == currentSelectedIndex ? UIColor.darkGray: UIColor.lightGray
           }
       }
    
    
}

extension SavingAndAssetsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSavings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavingsCell.id, for: indexPath)
        guard let savingsCell = cell as? SavingsCell else { return cell }
        
        if currentSelectedIndex == indexPath.row {
            cell.transformToLarge()
        }
        
        savingsCell.set(savings: allSavings[indexPath.item])
        return savingsCell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            let currentCell = collectionView.cellForItem(at: IndexPath(row: Int(currentSelectedIndex), section: 0))
            currentCell?.transformToStandard()
            
        }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == collectionView else {
            return
        }
        
        targetContentOffset.pointee = scrollView.contentOffset
        
        let flowLayout = collectionView.collectionViewLayout as! CellCollectionFlowLayout
        let cellWidthIncludingSpacing = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        let offset = targetContentOffset.pointee
        let horizontalVelocity = velocity.x
        
        var selectedIndex = currentSelectedIndex
        
        switch horizontalVelocity {
                // On swiping
            case _ where horizontalVelocity > 0 :
                selectedIndex = currentSelectedIndex + 1
            case _ where horizontalVelocity < 0:
                selectedIndex = currentSelectedIndex - 1
                
                // On dragging
            case _ where horizontalVelocity == 0:
                let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
                let roundedIndex = round(index)
                
                selectedIndex = Int(roundedIndex)
            default:
                print("Incorrect velocity for collection view")
        }
        
        let safeIndex = max(0, min(selectedIndex, allSavings.count - 1))
        let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
        
        flowLayout.collectionView!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        
        let previousSelectedIndex = IndexPath(row: Int(currentSelectedIndex), section: 0)
        let previousSelectedCell = collectionView.cellForItem(at: previousSelectedIndex)
        let nextSelectedCell = collectionView.cellForItem(at: selectedIndexPath)
        
        currentSelectedIndex = selectedIndexPath.row
        
        previousSelectedCell?.transformToStandard()
        nextSelectedCell?.transformToLarge()
    }
    
}

extension SavingAndAssetsController: UICollectionViewDelegate {
    
}

extension SavingAndAssetsController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let inset = 9.0
//        guard let screen = view.window?.windowScene?.screen else { return .zero }
//
//        let width = (screen.bounds.width - (inset * (5))) / 3
//        return CGSize(width: width, height: width)
//    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

            let edit = UIAction(
                title: "Edit",
                image: UIImage(systemName: "square.and.pencil"),
                identifier: nil,
                discoverabilityTitle: nil, state: .off) { [weak self] (_) in
                    guard let self else { return }
                    print("edit button clicked")
                    let nib = String(describing: AddController.self)
                    let editVC = AddController(nibName: nib, bundle: nil)
                    editVC.set(savings: self.allSavings[indexPath.row], type: .edit)
                    self.navigationController?.pushViewController(editVC, animated: true)
                
            }
            
            let delete = UIAction(
                title: "Delete",
                image: UIImage(systemName: "trash"),
                identifier: nil,
                discoverabilityTitle: nil,
                attributes: .destructive,
                state: .off) { [weak self] (_) in
                    print("delete button clicked")
                    guard let self else { return }

                RealmManager<SavingsModel>().delete(object: self.allSavings[indexPath.item])
                self.collectionView.deleteItems(at: [indexPath])
                self.allSavings = RealmManager<SavingsModel>().read()
                self.collectionView.reloadData()
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


extension UICollectionViewCell {
    func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func transformToStandard() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
    
}
