//
//  File.swift
//  Presentation
//
//  Created by Nhat Nguyen on 20/4/25.
//

import SwiftUI

public struct UserDetailView: View {
    
    @StateObject private var viewModel: UserDetailViewModel
    
    public init(viewModel: UserDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: DesignSystem.Padding.large) {
            UserListItemView(
                avatar: viewModel.avatar,
                name: viewModel.name,
                location: viewModel.location
            )
            
            HStack(spacing: 55) {
                StatInfoView(
                    iconName: "person.2.fill",
                    countText: "\(viewModel.noOfFollowers)",
                    label: "Followers"
                )
                
                StatInfoView(
                    iconName: "person.crop.square.fill",
                    countText: "\(viewModel.noOfFollowing)",
                    label: "Following"
                )
            }
            
            VStack(alignment: .leading, spacing: DesignSystem.Padding.small) {
                Text("Blog")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(viewModel.blog)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .expandWidth(alignment: .leading)
            .padding(.horizontal, DesignSystem.Padding.medium)
        }
        .expandHeight(alignment: .top)
        .onAppear {
            viewModel.getUserDetail()
        }
    }
}
