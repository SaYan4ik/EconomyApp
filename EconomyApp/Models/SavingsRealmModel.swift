//
//  SavingsRealmModel.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import Foundation
import RealmSwift


class SavingsRealmModel: Object {
    @objc dynamic var currency: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var image: Data?
    
    convenience init(currency: String, type: String, image: Data) {
        self.init()
        self.type = type
        self.image = image
    }
    
}
