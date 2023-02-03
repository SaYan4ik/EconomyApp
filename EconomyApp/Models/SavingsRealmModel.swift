//
//  SavingsRealmModel.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import Foundation
import RealmSwift


class SavingsModel: Object {
    @objc dynamic var currency: String = ""
    @objc dynamic var typeValue: TypeModel?
    
    convenience init(currency: String, typeValue: TypeModel) {
        self.init()
        self.currency = currency
        self.typeValue = typeValue
    }
    
}
