//
//  StatInfoView.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import SwiftUI

public struct StatInfoView: View {
    
    var iconName: String
    var countText: String
    var label: String
    
    public init(
        iconName: String,
        countText: String,
        label: String
    ) {
        self.iconName = iconName
        self.countText = countText
        self.label = label
    }

    public var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(
                        width: DesignSystem.ImageSize.xLarge,
                        height: DesignSystem.ImageSize.xLarge
                    )

                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
            }

            Text(countText)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)

            Text(label)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    StatInfoView(iconName: "person.fill", countText: "10+", label: "Following")
}
