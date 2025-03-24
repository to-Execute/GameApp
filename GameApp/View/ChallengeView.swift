//
//  ChallengeView.swift
//  GameApp
//
//  Created by SreeNath on 23/03/2025.
//

import SwiftUI

struct ChallengeView: View {
    @Binding var countDownTimer: Int
    @ObservedObject var viewModel: GameAppViewModel
    @State var timerRunning = true
    @Binding var showGameView: Bool
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("CHALLENGE")
                .foregroundStyle(.appBlack)
                .fontWeight(.semibold)
                .font(.system(size: 18))
            Text("WILL START IN")
                .foregroundStyle(.appBlack)
                .fontWeight(.semibold)
                .font(.system(size: 24))
            Text("\(countDownTimer)")
                .foregroundStyle(.timeSetter)
                .fontWeight(.semibold)
                .font(.system(size: 28.58))
                .onReceive(timer) { _ in
                    guard isActive else { return }
                    if countDownTimer > 0 && timerRunning {
                        countDownTimer -= 1
                    } else {
                        timerRunning = false
                        showGameView = true
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
        .padding()
    }
}
