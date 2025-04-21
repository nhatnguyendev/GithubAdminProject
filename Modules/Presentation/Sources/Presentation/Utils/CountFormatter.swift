//
//  CountFormatter.swift
//  Presentation
//
//  Created by Nhat Nguyen on 21/4/25.
//

import Foundation

struct CountFormatter {
    static func display(for count: Int, threshold: Int = 100) -> String {
        return count > threshold ? "\(threshold)+" : "\(count)"
    }
}
