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
    @IBOutlet weak var typeNameLabel: UILabel!
    
    static var id = String(describing: TypeCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.typeNameLabel.isHidden = true
    }

    func set(nameImage: String?, typeModel: TypeModel?) {
//        self.typeImageView.image = UIImage(systemName: nameImage ?? "")
        self.typeImageView.image = UIImage(named: nameImage ?? "")
        self.container.layer.cornerRadius = 12
        
        if typeModel != nil {
            self.typeNameLabel.isHidden = false
            guard let imageNew = typeModel?.image else { return }
            guard let image : UIImage = UIImage(data: imageNew)?.withRenderingMode(.alwaysTemplate) else { return }
            self.typeImageView.image = image
            
            self.typeNameLabel.text = typeModel?.type ?? ""
        } else {
            self.typeNameLabel.isHidden = true
        }
        
    }
    
}
