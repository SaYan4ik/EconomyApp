//
//  RealmManager.swift
//  EconomyApp
//
//  Created by Александр Янчик on 2.02.23.
//

import Foundation
import RealmSwift


class RealmManager<T> where T: Object {
    private let realm = try! Realm()
    
    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func update(realmBlock: @escaping (Realm) -> Void) {
        realmBlock(self.realm)
    }
    
    func read() -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func delete(object: T) {
        try? realm.write {
            realm.delete(object)
        }
    }
}
