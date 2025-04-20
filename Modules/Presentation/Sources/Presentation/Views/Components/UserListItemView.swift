//
//  UserRowView.swift
//  Presentation
//
//  Created by Nhat Nguyen on 19/4/25.
//

import SwiftUI

public struct UserListItemView: View {
    
    let avatar: URL?
    let name: String
    let link: String?
    let location: String?
    
    let imageSize: CGFloat = DesignSystem.ImageSize.xxxLarge
    
    public init(
        avatar: URL? = nil,
        name: String,
        link: String? = nil,
        location: String? = nil
    ) {
        self.avatar = avatar
        self.name = name
        self.link = link
        self.location = location
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Group {
                CachedAsyncImageView(url: avatar, imageSize: imageSize)
                    .padding(DesignSystem.Padding.medium)
                    .background(.gray.opacity(0.06))
                    .cornerRadius(DesignSystem.CornerRadius.small)
                
                VStack(alignment: .leading, spacing: DesignSystem.Padding.small) {
                    Text(name)
                        .font(.headline)
                    
                    Divider()
                    
                    if let link {
                        Text(link)
                            .font(.subheadline)
                            .foregroundColor(.blue.opacity(0.5))
                    }
                    
                    if let location {
                        LocationLabelView(locationName: location)
                    }
                }
            }
            .padding()
        }
        .expandWidth(alignment: .leading)
        .background(.white)
        .cornerRadius(DesignSystem.CornerRadius.small)
        .customShadow(color: .black.opacity(0.3))
        .padding(.horizontal, DesignSystem.Padding.medium)
        .padding(.vertical, DesignSystem.Padding.small)
    }
}

#Preview {
    UserListItemView(
        avatar: URL(string: "https://avatars.githubusercontent.com/u/101?v=4")!,
        name: "Test Name",
        link: "https://linkedin"
    )
}
