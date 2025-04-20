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
                avatar: URL(string: viewModel.user?.avatarURL ?? "")!,
                name: viewModel.user?.login ?? "",
                link: viewModel.user?.htmlURL ?? ""
            )
        }
        .expandHeight(alignment: .top)
        .onAppear {
            viewModel.getUserDetail()
        }
    }
}
