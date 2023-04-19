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
    let position: CGPoint
    var selected : Bool
    var spawned : Bool
    let spawningName : String
    var changedStats: Bool
    var count : Int
}


var cards = [
    Card(cardID: 1, name: "Nuclear Power Plant", imageName: "NuclearPowerPlant", type: .power, budget: 60, pollutionStats: 0.14, socialImpact: -0.84, description: "This is a nuclear power plant", position: CGPoint(x: 100, y: -50), selected: false, spawned: false, spawningName: "NuclearPlant2D", changedStats: false, count: 0),
    Card(cardID: 2, name: "Coal Power Plant", imageName: "CoalPowerPlant", type: .power, budget: 40, pollutionStats: 0.7, socialImpact: -0.4, description: "This is a coal power plant", position: CGPoint(x: -280, y: -150), selected: false, spawned: false, spawningName: "CoalPlant2D", changedStats: false, count: 0),
    Card(cardID: 3, name: "Solar arrays", imageName: "SolarArraysCard", type: .power, budget: 15, pollutionStats: 0.1, socialImpact: -0.05, description: "This is a huge solar panel field", position: CGPoint(x: 200, y: -100), selected: false, spawned: false, spawningName: "SolarArrays2D", changedStats: false, count: 0),
    Card(cardID: 4, name: "Wind Farm", imageName: "WindFarmCard", type: .power, budget: 20, pollutionStats: 0.1, socialImpact: -0.75, description: "This is a huge solar panel field", position: CGPoint(x: -285, y: -230), selected: false, spawned: false, spawningName: "WindFarm2D", changedStats: false, count: 0),
    Card(cardID: 5, name: "Oil Power Plant", imageName: "OilPowerPlantCard", type: .power, budget: 35, pollutionStats: 0.8, socialImpact: -0.4, description: "This is an oil power plant", position: CGPoint(x: -120, y: 160), selected: false, spawned: false, spawningName: "OilPowerPlantCard2D", changedStats: false, count: 0),
    Card(cardID: 6, name: "Geothermal Power Plant", imageName: "GeothermalPowerPlantCard", type: .power, budget: 50, pollutionStats: -0.02, socialImpact: 0.2, description: "This is a geothermal power plant", position: CGPoint(x: 140, y: -420), selected: false, spawned: false, spawningName: "GeothermalPowerPlant2D", changedStats: false, count: 0),
    Card(cardID: 7, name: "Education", imageName: "educationCard", type: .social, budget: 10, pollutionStats: -0.05, socialImpact: 0.2, description: "This will generate more education in your country", position: CGPoint(x: -585, y: -260), selected: false, spawned: false, spawningName: "education2D", changedStats: false, count: 0),
    Card(cardID: 8, name: "Waste sorting", imageName: "wasteSortingCard", type: .social, budget: 10, pollutionStats: -0.25, socialImpact: 0.2, description: "Help your country with waste sorting", position: CGPoint(x: -585, y: -200), selected: false, spawned: false, spawningName: "wasteSorting2D", changedStats: false, count: 0),
    Card(cardID: 9, name: "Electric vehicles", imageName: "electricVehiclesCard", type: .social, budget: 20, pollutionStats: -0.2, socialImpact: -0.2, description: "Give discounts on electric vehicles", position: CGPoint(x: -585, y: -140), selected: false, spawned: false, spawningName: "electricVehicles2D", changedStats: false, count: 0),
]

func resetCards(){
    for i in 0..<cards.count {
        cards[i].selected = false
        cards[i].spawned = false
    }
}
