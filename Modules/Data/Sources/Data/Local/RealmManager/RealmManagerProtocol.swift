//
//  RealmManagerProtocol.swift
//  Data
//
//  Created by Nhat Nguyen on 21/4/25.
//

import RealmSwift

public protocol RealmManagerProtocol {
    func get<T: Object>(_ type: T.Type) -> [T]
    func write<T: Object>(_ objects: [T]) throws
    func write<T: Object>(_ object: T) throws
}
