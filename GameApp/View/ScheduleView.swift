//
//  ScheduleView.swift
//  GameApp
//
//  Created on 23/03/2025.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: GameAppViewModel
    @State var hrFirstDigit: String = ""
    @State var hrSecondDigit: String = ""
    @State var minFirstDigit: String = ""
    @State var minSecondDigit: String = ""
    @State var secFirstDigit: String = ""
    @State var secSecondDigit: String = ""
    @Binding var showChallengeView: Bool
    @Binding var timeRemaining: Int
    
    var body: some View {
        VStack {
            Text("SCHEDULE")
                .foregroundStyle(.appBlack)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .padding(.bottom, 10)
            
            HStack(spacing: 10) {
                VStack {
                    Text("Hours")
                        .foregroundStyle(.appBlack)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                    HStack(spacing: 3) {
                        TextField("0", text: $hrFirstDigit)
                            .frame(width: 53, height: 53)
                            .foregroundStyle(.timeSetter)
                            .background(RoundedRectangle(cornerRadius: 7).fill(.scheduleBox))
                        TextField("0", text: $hrSecondDigit)
                            .frame(width: 53, height: 53)
                            .foregroundStyle(.timeSetter)
                            .background(RoundedRectangle(cornerRadius: 7).fill(.scheduleBox))
                    }
                }
                VStack {
                    Text("Minute")
                        .foregroundStyle(.appBlack)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                    HStack(spacing: 3) {
                        TextField("0", text: $minFirstDigit)
                            .frame(width: 53, height: 53)
                            .foregroundStyle(.timeSetter)
                            .background(RoundedRectangle(cornerRadius: 7).fill(.scheduleBox))
                        TextField("0", text: $minSecondDigit)
                            .frame(width: 53, height: 53)
                            .foregroundStyle(.timeSetter)
                            .background(RoundedRectangle(cornerRadius: 7).fill(.scheduleBox))
                    }
                }
                VStack {
                    Text("Second")
                        .foregroundStyle(.appBlack)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                    HStack(spacing: 3) {
                        TextField("0", text: $secFirstDigit)
                            .frame(width: 53, height: 53)
                            .foregroundStyle(.timeSetter)
                            .background(RoundedRectangle(cornerRadius: 7).fill(.scheduleBox))
                        TextField("0", text: $secSecondDigit)
                            .frame(width: 53, height: 53)
                            .foregroundStyle(.timeSetter)
                            .background(RoundedRectangle(cornerRadius: 7).fill(.scheduleBox))
                    }
                }
                
            }
            Button{
                showChallengeView = true
                let setHrs = Int(hrFirstDigit + hrSecondDigit) ?? 0
                let setMin = Int(minFirstDigit + minSecondDigit) ?? 0
                let setSec = Int(secFirstDigit + secSecondDigit) ?? 0
                timeRemaining = calculateTime(hours: setHrs, minutes: setMin, seconds: setSec)
            } label: {
                Text("Save")
                    .foregroundStyle(.appWhite)
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(RoundedRectangle(cornerRadius: 7).fill(.navBar))
            }
            .padding()
        }
        .padding()
        
    }
    func calculateTime(hours: Int, minutes: Int, seconds: Int) -> Int{
        if hours != 0 && minutes != 0  && seconds != 0 {
            return hours*minutes*seconds
        } else if hours != 0 && minutes == 0  && seconds == 0 {
            return hours
        } else if hours != 0 && minutes != 0  && seconds == 0 {
            return hours*minutes
        } else if hours == 0 && minutes == 0  && seconds != 0 {
            return seconds
        } else if hours != 0 && minutes != 0  && seconds != 0 {
            return minutes*seconds
        } else if hours != 0 && minutes == 0  && seconds != 0 {
            return hours*seconds
        }
        return 0
    }
    func countDownTimer(time: Int) -> String{
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}
