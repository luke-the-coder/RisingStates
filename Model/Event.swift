//
//  Event.swift
//  
//
//  Created by luke-the-coder on 11/04/23.
//


import Foundation

enum EventType: String {
    case power
    case politics
    case social
    case tutorial
    case environment
    case naturalDisaster
    case other
}

struct Event {
    let EventID : Int
    let name : String
    let imageName : String
    let type : EventType
    let budget : Int // As Milions
    let pollutionStats : CGFloat
    let socialImpact : CGFloat
    let description : String
}


var events = [
    Event(EventID: 1, name: "Introduction", imageName: "randomEvent1", type: .tutorial, budget: 0, pollutionStats: 0, socialImpact: 0, description: "Intro of the game"),
    Event(EventID: 2, name: "Clean Energy Initiative", imageName: "europeanUnion1", type: .power, budget: 50, pollutionStats: 0, socialImpact: 0, description: "The european union is investing in renewable energy, you receive 50M and a bonus on social impact!"),
    Event(EventID: 3, name: "Environmental Protest", imageName: "protest", type: .politics, budget: 0, pollutionStats: 0, socialImpact: 0.1, description: "A group of citizens is protesting against the government's lack of action on environmental issues. You must address their concerns or risk losing public support!"),
    Event(EventID: 4, name: "Oil Spill", imageName: "oilspill", type: .environment, budget: -10, pollutionStats: 0.2, socialImpact: 0.2, description: "An oil spill has occurred in your state sea, causing significant environmental damage and health hazards. You must take action to mitigate the impact on the environment and public health!"),
    Event(EventID: 5, name: "Nuclear Power Plant Disaster", imageName: "nuclear", type: .power, budget: -30, pollutionStats: 0.4, socialImpact: 0.1, description: "A nuclear power plant has experienced a catastrophic failure, causing significant environmental and health hazards. You must take immediate action to contain the disaster and mitigate its impact!"),
    Event(EventID: 6, name: "Natural Disaster: Tornado", imageName: "tornado", type: .naturalDisaster, budget: -10, pollutionStats: 0, socialImpact: 0, description: "A tornado has hit your state, causing extensive damage and displacement of residents. You must provide emergency aid and work to rebuild the affected areas!"),
    Event(EventID: 7, name: "Green Infrastructure Initiative", imageName: "greenInfrastructure", type: .politics, budget: 20, pollutionStats: 0, socialImpact: 0, description: "The government is investing in green infrastructure, such as bike lanes and green roofs. You receive 20M"),
    Event(EventID: 8, name: "Renewable Energy Innovation", imageName: "renewableEnergy", type: .power, budget: 40, pollutionStats: -0.2, socialImpact: 0, description: "A new technology for renewable energy has been developed in your state, and you have the opportunity to invest in it. You receive 40M and a bonus on pollution reduction and social impact!"),
    Event(EventID: 9, name: "Paris Agreement on Climate Change", imageName: "parisAgreement", type: .politics, budget: 60, pollutionStats: -0.1, socialImpact: 0, description: "The Paris Agreement is an international treaty signed by multiple countries in 2016, with the goal of limiting global warming to well below 2 degrees Celsius above pre-industrial levels. Your state is a signatory to the agreement, and you must work to meet the emissions reduction targets set forth in the treaty."),
    Event(EventID: 10, name: "European Union help package", imageName: "europeanUnion2", type: .politics, budget: 40, pollutionStats: 0, socialImpact: 0, description: "The European Union is sending money packages to his state members to help the recovery of the pandemic.")
]
