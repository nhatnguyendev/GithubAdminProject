//
//  LocationLabelView.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import SwiftUI

public struct LocationLabelView: View {
    
    var locationName: String
    
    public init(locationName: String) {
        self.locationName = locationName
    }
    
    public var body: some View {
        HStack(spacing: DesignSystem.Padding.small) {
            Image(systemName: "mappin.circle.fill")
                .font(.subheadline)
            
            Text(locationName)
                .font(.subheadline)
        }
        .foregroundColor(.gray)
    }
}
