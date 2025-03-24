//
//  GameView.swift
//  GameApp
//
//  Created by SreeNath on 23/03/2025.
//

import SwiftUI
import Foundation

struct GameView: View {
    @ObservedObject var viewModel: GameAppViewModel
    @State var isTappedOption1: Bool = false
    @State var isTappedOption2: Bool = false
    @State var isTappedOption3: Bool = false
    @State var isTappedOption4: Bool = false
    @State var isCorrect: Bool = false
    @State var showAnswer: Bool = false
    @State var selectedOption = 0
    @State var options: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("\(viewModel.currentIndex + 1)")
                Text("GUESS THE COUNTRY FROM THE FLAG ?")
            }
            
                HStack {
                Image(viewModel.countryCode.lowercased())
                VStack(spacing: 10) {
                    
                    Button{
                        isTappedOption1.toggle()
                        if isTappedOption1 {
                            if let key = viewModel.options.someKey(forValue: viewModel.options.values.sorted()[0]) {
                                viewModel.checkAnswer(optionId: key)
                                selectedOption = key
                            }
                        }
                    
                    } label: {
                        Text(viewModel.options.values.sorted()[0])
                            .lineLimit(1)
                    }
                    .modifier(OptionsButtonModifier(isTapped: $isTappedOption1, isCorrect: .constant(true)))
                    .padding(.bottom, -7)
                    
                    if isTappedOption1 {
                        Text(viewModel.isCorrect ? "Correct" : "Wrong")
                            .foregroundStyle(viewModel.isCorrect ? .correctAnswer : .wrongAnswer)
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                    }
                    
                    Button{
                        isTappedOption2.toggle()
                        if isTappedOption2 {
                            if let key = viewModel.options.someKey(forValue: viewModel.options.values.sorted()[1]) {
                                viewModel.checkAnswer(optionId: key)
                            }
                        }
                    } label: {
                        Text(viewModel.options.values.sorted()[1])
                            .lineLimit(1)
                    }
                    .modifier(OptionsButtonModifier(isTapped: $isTappedOption2, isCorrect: .constant(true) ))
                    .padding(.bottom, -7)
                    
                    if isTappedOption2 {
                        Text(viewModel.isCorrect ? "Correct" : "Wrong")
                            .foregroundStyle(viewModel.isCorrect ? .correctAnswer : .wrongAnswer)
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                    }
                    
                }
                VStack(spacing: 10) {
                    Button{
                        isTappedOption3.toggle()
                        if isTappedOption3 {
                            if let key = viewModel.options.someKey(forValue: viewModel.options.values.sorted()[2]) {
                                viewModel.checkAnswer(optionId: key)
                            }
                        }
                    } label: {
                        Text(viewModel.options.values.sorted()[2])
                            .lineLimit(1)
                    }
                    .modifier(OptionsButtonModifier(isTapped: $isTappedOption3, isCorrect: .constant(false)))
                    .padding(.bottom, -7)
                    
                    if isTappedOption3 {
                        Text(viewModel.isCorrect ? "Correct" : "Wrong")
                            .foregroundStyle(viewModel.isCorrect ? .correctAnswer : .wrongAnswer)
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                    }
                    
                    Button{
                        isTappedOption4.toggle()
                        if isTappedOption4 {
                            if let key = viewModel.options.someKey(forValue: viewModel.options.values.sorted()[3]) {
                                viewModel.checkAnswer(optionId: key)
                            }
                        }
                    } label: {
                        Text(viewModel.options.values.sorted()[3])
                            .lineLimit(1)
                    }
                    .modifier(OptionsButtonModifier(isTapped: $isTappedOption4, isCorrect: .constant(true) ))
                    .padding(.bottom, -7)
                    
                    if isTappedOption4 {
                        Text(viewModel.isCorrect ? "Correct" : "Wrong")
                            .foregroundStyle(viewModel.isCorrect ? .correctAnswer : .wrongAnswer)
                            .fontWeight(.regular)
                            .font(.system(size: 12))
                    }
                }
        }
        
        }
        .padding()
    }
}
extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
