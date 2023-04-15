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
}


var cards = [
    Card(cardID: 1, name: "Nuclear Power Plant", imageName: "NuclearPowerPlant", type: .power, budget: 60, pollutionStats: 0.14, socialImpact: 0.84, description: "This is a nuclear power plant", position: CGPoint(x: 100, y: -50), selected: false, spawned: false, spawningName: "NuclearPlant2D", changedStats: false),
    Card(cardID: 2, name: "Coal Power Plant", imageName: "CoalPowerPlant", type: .power, budget: 40, pollutionStats: 0.7, socialImpact: 0.4, description: "This is a coal power plant", position: CGPoint(x: -280, y: -150), selected: false, spawned: false, spawningName: "CoalPlant2D", changedStats: false),
    Card(cardID: 3, name: "Solar arrays", imageName: "SolarArraysCard", type: .power, budget: 15, pollutionStats: 0.1, socialImpact: 0.3, description: "This is a huge solar panel field", position: CGPoint(x: 200, y: -100), selected: false, spawned: false, spawningName: "SolarArrays2D", changedStats: false),
    Card(cardID: 4, name: "Wind Farm", imageName: "WindFarmCard", type: .power, budget: 20, pollutionStats: 0.1, socialImpact: 0.75, description: "This is a huge solar panel field", position: CGPoint(x: -285, y: -230), selected: false, spawned: false, spawningName: "WindFarm2D", changedStats: false),
    Card(cardID: 5, name: "Oil Power Plant", imageName: "OilPowerPlantCard", type: .power, budget: 35, pollutionStats: 0.8, socialImpact: 0.4, description: "This is an oil power plant", position: CGPoint(x: -120, y: 160), selected: false, spawned: false, spawningName: "OilPowerPlantCard2D", changedStats: false),
       Card(cardID: 6, name: "Geothermal Power Plant", imageName: "GeothermalPowerPlantCard", type: .power, budget: 50, pollutionStats: 0.02, socialImpact: 0.2, description: "This is a geothermal power plant", position: CGPoint(x: 140, y: -420), selected: false, spawned: false, spawningName: "GeothermalPowerPlant2D", changedStats: false)
]
