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


let events = [
    Event(EventID: 1, name: "Clean Energy Initiative", imageName: "clean_energy", type: .power, budget: 100, pollutionStats: -0.2, socialImpact: 0.3, description: "Invest in renewable energy sources to reduce carbon emissions."),
    Event(EventID: 2, name: "Public Transportation Upgrade", imageName: "public_transport", type: .social, budget: 50, pollutionStats: -0.1, socialImpact: 0.5, description: "Upgrade public transportation systems to reduce traffic congestion and promote sustainable travel.")
]
