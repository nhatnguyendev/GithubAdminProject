//
//  File.swift
//  Presentation
//
//  Created by Nhat Nguyen on 19/4/25.
//

import Foundation
import SwiftUI

public extension View {
    func expandWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func expandHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func expand(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

public extension View {
    func customShadow(
        color: Color = .black,
        opacity: CGFloat = 0.3,
        radius: CGFloat = 8,
        x: CGFloat = 0,
        y: CGFloat = 4
    ) -> some View {
        modifier(CustomShadowModifier(
            color: color,
            opacity: opacity,
            radius: radius,
            x: x,
            y: y
        ))
    }
}

public extension View {
    func zeroListPadding() -> some View {
        self
            .listStyle(PlainListStyle())
            .listRowInsets(EdgeInsets())
    }
}

extension View {
    func hyperlink(_ urlString: String) -> some View {
        self
            .foregroundColor(.blue.opacity(0.5))
            .underline()
            .onTapGesture {
                guard let url = URL(string: urlString) else { return }
                UIApplication.shared.open(url)
            }
    }
}
