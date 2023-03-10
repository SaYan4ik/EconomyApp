//
//  TypeRealmModel.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import Foundation
import RealmSwift


class TypeModel: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var image: Data?
    
    convenience init(type: String, image: Data) {
        self.init()
        self.type = type
        self.image = image
    }
    
}
