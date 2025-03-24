//
//  GameAppView.swift
//  GameApp
//
//  Created on 23/03/2025.
//

import SwiftUI
import Foundation

struct GameAppView: View {
    @ObservedObject var viewModel: GameAppViewModel
    @State var hrFistDigit: String = ""
    @State var hrSecondDigit: String = ""
    @State var minFirstDigit: String = ""
    @State var minSecondDigit: String = ""
    @State var secFistDigit: String = ""
    @State var secSecondDigit: String = ""
    @State var isTapped: Bool = false
    @State var isCorrect: Bool = true
    @State var showChallengeView: Bool = false
    @State var showGameView: Bool = false
    @State var showGameOver: Bool = false
    @State var timeRemaining = 0
    @State var countDownTimer: Int = 1
    @State var questionTimer: Int = 00
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let interval = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    var questionIntervel = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    VStack(alignment: .leading, spacing: 0){
                        HStack {
                            Text("00:\(questionTimer)")
                                .foregroundStyle(.appWhite)
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .padding()
                                .background( UnevenRoundedRectangle(
                                    topLeadingRadius: 7.0,
                                    bottomLeadingRadius: 0.0,
                                    bottomTrailingRadius: 7.0,
                                    topTrailingRadius: 7.0))
                                .onReceive(questionIntervel) { time in
                                        guard isActive else { return }
                                    if questionTimer < 30 {
                                        if showGameView {
                                            questionTimer += 1
                                        }
                                    } else {
                                        questionTimer = 0
                                        timer.upstream.connect().cancel()
                                    }
                                        
                                    }
                            
                            
                            Text("FLAGS CHALLENGE")
                                .foregroundStyle(.navBar)
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                                .padding(.leading, 30)
                            
                            
                        }
                        
                        Divider()
                    }
                    
                    if !showChallengeView {
                        ScheduleView( viewModel: viewModel, showChallengeView: $showChallengeView, timeRemaining: $timeRemaining)
                    }
                    if showChallengeView && !showGameView{
                        ChallengeView(countDownTimer: $countDownTimer, viewModel: viewModel, showGameView: $showGameView)
                    }
                    if showGameView && timeRemaining != 0 && countDownTimer == 0 {
                        GameView(viewModel: viewModel)
                    }
                    if timeRemaining == 0 && countDownTimer == 0{
                        GameOverView(showScore: false, score: 70)
                    }
                    
                }
                .toolbarBackground(.navBar, for: .navigationBar)
                .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                .frame(width: UIScreen.main.bounds.width - 20)
                .background(RoundedRectangle(cornerRadius: 7).stroke(isTapped ? .appBlack : .clear).fill(.section).opacity(0.3))
                .padding(.top, 20)
                .onAppear {
                    viewModel.getQuestions()
                    viewModel.singleQuestion()
                }
                Spacer()
            }
            .onReceive(timer) { time in
                guard isActive else { return }
                if showGameView {
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            }
            .onReceive(questionIntervel) { time in
                    guard isActive else { return }
                    
                if questionTimer < 30 {
                    if viewModel.currentIndex == viewModel.questions.count - 1{
                        timer.upstream.connect().cancel()
                    }
                } else {
                    questionTimer = 0
                    viewModel.currentIndex += 1
                    viewModel.singleQuestion()
                    print(viewModel.currentIndex)
                    timer.upstream.connect().cancel()
                }
                    
                }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    isActive = true
                } else {
                    isActive = false
                }
            }
        }
    }
    func stopTimer() {
            self.questionIntervel.upstream.connect().cancel()
        }
        
    mutating func startTimer() {
        self.questionIntervel = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
}

struct GameOverView: View {
    @State var showScore: Bool = false
    @State var score: Int = 0
    var finalScore: AttributedString {
        var title = AttributedString("SCORE: ")
        var subTitle = AttributedString("\(score)/100")
        title.font = .system(size: 20, weight: .regular)
        title.foregroundColor = .navBar
        subTitle.font = .system(size: 30, weight: .semibold)
        subTitle.foregroundColor = .buttonStroke
        return title + subTitle
    }
    var body: some View {
        VStack {
            if showScore {
                HStack {
                    Text(finalScore)
                        .padding()
                        
                }
            } else {
                Text("GAME OVER")
                    .foregroundStyle(.buttonStroke)
                    .fontWeight(.semibold)
                    .font(.system(size: 36))
                    .padding()
            }
        }
    }
}
