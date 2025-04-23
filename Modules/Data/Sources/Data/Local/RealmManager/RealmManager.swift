//
//  RealmManager.swift
//  Data
//
//  Created by Nhat Nguyen on 21/4/25.
//

import RealmSwift

enum RealmError: Error {
    case realmNotInitialized
}

public final class RealmManager: RealmManagerProtocol {
    
    private var realm: Realm?
    private let configuration: Realm.Configuration
    public static let schemaVersion: UInt64 = 1
    
    public init(configuration: Realm.Configuration = Realm.Configuration(
        schemaVersion: RealmManager.schemaVersion,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < RealmManager.schemaVersion {
                // Handle migration logic here if needed
            }
        }
    ))
    {
        self.configuration = configuration
        
        do {
            self.realm = try Realm(configuration: configuration)
        } catch {
            print("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    public func get<T: Object>(_ type: T.Type) -> [T] {
        guard let realm = realm else {
            return []
        }
        let objects = realm.objects(type)
        return Array(objects)
    }
    
    public func write<T: Object>(_ objects: [T]) throws {
        guard let realm = realm else {
            throw RealmError.realmNotInitialized
        }
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            throw error
        }
    }
    
    public func write<T: Object>(_ object: T) throws {
        guard let realm = realm else {
            throw RealmError.realmNotInitialized
        }
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            throw error
        }
    }
    
}
