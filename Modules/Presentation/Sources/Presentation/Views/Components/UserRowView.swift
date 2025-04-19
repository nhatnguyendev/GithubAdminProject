//
//  UserRowView.swift
//  Presentation
//
//  Created by Nhat Nguyen on 19/4/25.
//

import SwiftUI

public struct UserRowView: View {
    
    let avatar: URL
    let name: String
    let link: String
    
    let imageSize: CGFloat = DesignSystem.ImageSize.xxLarge
    
    public init(avatar: URL, name: String, link: String) {
        self.avatar = avatar
        self.name = name
        self.link = link
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Group {
                AsyncImage(url: avatar) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                            .background(Circle().fill(Color.gray.opacity(0.2)))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .clipShape(Circle()) // Ensure the image is circular
                    case .failure:
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                            .foregroundColor(.blue)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: imageSize, height: imageSize)
                .padding(DesignSystem.Padding.medium)
                .background(.gray.opacity(0.06))
                .cornerRadius(DesignSystem.CornerRadius.small)
                
                VStack(alignment: .leading, spacing: DesignSystem.Padding.xSmall) {
                    Text(name)
                        .font(.headline)
                    
                    Divider()
                    
                    Text(link)
                        .font(.subheadline)
                        .foregroundColor(.blue.opacity(0.5))
                }
            }
            .padding()
        }
        .expandWidth(alignment: .leading)
        .background(.white)
        .cornerRadius(DesignSystem.CornerRadius.small)
        .customShadow(color: .black.opacity(0.5))
        .padding(.horizontal, DesignSystem.Padding.large)
    }
}

#Preview {
    UserRowView(
        avatar: URL(string: "https://avatars.githubusercontent.com/u/101?v=4")!,
        name: "Test Name",
        link: "https://linkedin"
    )
}
