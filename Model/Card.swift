//
//  Card.swift
//  RisingStates
//
//  Created by luke-the-coder on 11/04/23.
//

import Foundation

enum CardType: String {
    case power
    case politics
    case social
}

struct Card {
    let cardID : Int
    let name : String
    let imageName : String
    let type : CardType
    let budget : Int // As Milions
    let pollutionStats : CGFloat
    let socialImpact : CGFloat
    let description : String
}


let cards = [
    Card(cardID: 1, name: "Nuclear Power Plant", imageName: "nuclearPowerPlant", type: .power, budget: 6000, pollutionStats: 0.14, socialImpact: 0.84, description: "This is a nuclear power plant"),
    Card(cardID: 2, name: "Card 2", imageName: "image2", type: .politics, budget: 200, pollutionStats: 0.7, socialImpact: 0.4, description: "Description for Card 2")
]
