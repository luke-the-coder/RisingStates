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
    Event(EventID: 2, name: "Clean Energy Initiative", imageName: "cleanEnergy", type: .power, budget: 100, pollutionStats: 0, socialImpact: 0.2, description: "The european union is investing in renewable energy, you receive 50M and a bonus on social impact!"),
    Event(EventID: 3, name: "Environmental Protest", imageName: "protest", type: .politics, budget: -50, pollutionStats: -0.05, socialImpact: -0.1, description: "A group of citizens is protesting against the government's lack of action on environmental issues. You must address their concerns or risk losing public support!"),
    Event(EventID: 7, name: "Oil Spill", imageName: "oilspill", type: .environment, budget: -150, pollutionStats: 0.2, socialImpact: -0.2, description: "An oil spill has occurred in your city's waterways, causing significant environmental damage and health hazards. You must take action to mitigate the impact on the environment and public health!"),
    Event(EventID: 11, name: "Nuclear Power Plant Disaster", imageName: "nuclear", type: .power, budget: -300, pollutionStats: 0.5, socialImpact: -0.3, description: "A nuclear power plant has experienced a catastrophic failure, causing significant environmental and health hazards. You must take immediate action to contain the disaster and mitigate its impact!"),
    Event(EventID: 13, name: "Natural Disaster: Tornado", imageName: "tornado", type: .naturalDisaster, budget: -100, pollutionStats: 0, socialImpact: -0.2, description: "A tornado has hit your state, causing extensive damage and displacement of residents. You must provide emergency aid and work to rebuild the affected areas!"),
    Event(EventID: 19, name: "Water Pollution Crisis", imageName: "water", type: .environment, budget: -50, pollutionStats: 0.3, socialImpact: -0.1, description: "A water pollution crisis has occurred in your state, which has serious health and environmental implications. You must take action to address the source of pollution and clean up affected areas!"),

    

]
