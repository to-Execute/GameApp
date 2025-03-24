//
//  GameAppViewModel.swift
//  GameApp
//
//  Created on 23/03/2025.
//

import Foundation
import SwiftUI
class GameAppViewModel: ObservableObject {
    @Published var questions : [Question] = []
    @Published var countries : [Country] = []
    @Published var options = Dictionary<Int, String>()
    @Published var countryCode: String = ""
    @Published var answerID : Int = 0
    @Published var currentIndex: Int = 0
    @Published var countDown: String = ""
    @Published var isCorrect: Bool = false
    
    func getQuestions() {
        NetworkServices.shared.parseJson(GameAppModel.self, file: "questions.json") { response, data  in
            print(response)
            if response == "success" {
              
                self.questions = data.questions
                print(self.questions.count)
            } else {
                
            }
        }
    }
    func singleQuestion() {
        
        let currentQuestion = self.questions[currentIndex]
        self.answerID = currentQuestion.answerID
        self.countryCode = currentQuestion.countryCode
        for  country in currentQuestion.countries {
            self.options[country.id] = country.countryName
         }
        
    }
    func checkAnswer(optionId: Int) {
        if optionId == self.answerID {
            self.isCorrect = true
        } else {
            self.isCorrect = false
        }
    }
}
