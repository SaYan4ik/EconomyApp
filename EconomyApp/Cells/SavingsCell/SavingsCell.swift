//
//  SavingsCell.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class SavingsCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var amounLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    static var id = String(describing: SavingsCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(savings: SavingsModel) {
        guard let imageNew = savings.typeValue?.image,
              let image : UIImage = UIImage(data: imageNew)?.withRenderingMode(.alwaysTemplate),
              let type = savings.typeValue?.type
        else { return }
        self.typeImage.image = image
        
        self.amounLabel.text = savings.currency
        self.typeLabel.text = type
        self.container.layer.cornerRadius = 12
    }
}
