//
//  CellCollectionFlowLayout.swift
//  EconomyApp
//
//  Created by Александр Янчик on 3.02.23.
//

import UIKit

class CellCollectionFlowLayout: UICollectionViewFlowLayout {
    private let itemHeight = 150
    private let itemWidth = 225
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let peekingItemWidth = itemSize.width / 10
        let horizontalInsets = (collectionView.frame.size.width - itemSize.width) / 2
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInsets, bottom: 0, right: horizontalInsets)
        minimumLineSpacing = horizontalInsets - peekingItemWidth
    }
}
