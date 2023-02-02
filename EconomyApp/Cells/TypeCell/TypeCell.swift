//
//  TypeCell.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import UIKit

class TypeCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var typeImageView: UIImageView!
    
    static var id = String(describing: TypeCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(nameImage: String) {
        self.typeImageView.image = UIImage(systemName: nameImage)
        self.container.layer.cornerRadius = 12
    }
    
}
