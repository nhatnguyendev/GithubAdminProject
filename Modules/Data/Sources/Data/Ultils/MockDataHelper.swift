//
//  MockDataHelper.swift
//  Data
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation

class MockDataHelper {
    static func loadJSONFile<T: Codable>(filename: String, type: T.Type) -> T? {
        
        guard let url = Bundle.module.url(forResource: filename, withExtension: "json") else {
            print("Mock file \(filename) not found in bundle")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("Failed to decode mock file: \(error)")
            return nil
        }
    }
}
