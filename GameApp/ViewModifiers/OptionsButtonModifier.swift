//
//  OptionsButtonModifier.swift
//  GameApp
//
//  Created on 23/03/2025.
//
import SwiftUI


struct OptionsButtonModifier: ViewModifier {
    @Binding var isTapped: Bool
    @Binding var isCorrect: Bool
    func body(content: Content) -> some View {
        content
            .foregroundStyle(isTapped ? .appWhite : .selectedOption)
            .fontWeight(.semibold)
            .font(.system(size: 12.4))
            .padding(.vertical, 5)
            .padding(.horizontal, 40)
            .background(RoundedRectangle(cornerRadius: 7).fill(isTapped ? .navBar : isCorrect ? .correctAnswer : .appWhite).stroke(isTapped ? .buttonStroke : .correctAnswer))
    }
    
    
}
