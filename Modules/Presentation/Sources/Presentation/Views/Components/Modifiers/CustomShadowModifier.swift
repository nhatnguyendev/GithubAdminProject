//
//  CustomShadowModifier.swift
//  Presentation
//
//  Created by Nhat Nguyen on 19/4/25.
//

import SwiftUI

public struct CustomShadowModifier: ViewModifier {
    let color: Color
    let opacity: CGFloat
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    public init(
        color: Color = .black,
        opacity: CGFloat = 0.08,
        radius: CGFloat = 12,
        x: CGFloat = 0,
        y: CGFloat = 4
    ) {
        self.color = color
        self.opacity = opacity
        self.radius = radius
        self.x = x
        self.y = y
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(
                color: color.opacity(opacity),
                radius: radius,
                x: x,
                y: y
            )
    }
}
