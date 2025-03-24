//
//  GameAppModel.swift
//  GameApp
//
//  Created on 23/03/2025.
//

import Foundation


struct GameAppModel: Codable {

    
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable{
    let answerID: Int
    let countries: [Country]
    let countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case countries
        case countryCode = "country_code"
    }
}

// MARK: - Country
struct Country: Codable, Hashable {
    let countryName: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case countryName = "country_name"
        case id
    }
}


