//
//  OptionalExtension.swift
//  EconomyApp
//
//  Created by Александр Янчик on 4.02.23.
//

import Foundation

extension Optional where Wrapped == String {
    
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
