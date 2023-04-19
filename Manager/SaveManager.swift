//
//  SaveManager.swift
//  
//
//  Created by luke-the-coder on 10/04/23.
//
import Foundation
class SaveManager {    
    static func saveGameState(scene: GameScene) {
        let defaults = UserDefaults.standard
        defaults.set(scene.time, forKey: "time")
        defaults.set(scene.pollution, forKey: "pollution")
        defaults.set(scene.socialImpact, forKey: "socialImpact")
        defaults.set(scene.currentlyGoing, forKey: "currentlyGoing")
        defaults.set(scene.budget, forKey: "budget")
        defaults.set(scene.showingMenu, forKey: "showingMenu")
        defaults.synchronize()
    }

    static func loadGameState(scene: GameScene) {
        let defaults = UserDefaults.standard
        scene.time = defaults.double(forKey: "time")
        scene.pollution = defaults.double(forKey: "pollution")
        scene.socialImpact = defaults.double(forKey: "socialImpact")
        scene.currentlyGoing = defaults.bool(forKey: "currentlyGoing")
        scene.budget = defaults.integer(forKey: "budget")
        scene.showingMenu = defaults.bool(forKey: "showingMenu")
    }
    
    static func resetGameState() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "time")
        defaults.removeObject(forKey: "pollution")
        defaults.removeObject(forKey: "socialImpact")
        defaults.removeObject(forKey: "currentlyGoing")
        defaults.removeObject(forKey: "budget")
        defaults.synchronize()
    }
    
    static func isSaveDataAvailable() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "time") == nil ||
            defaults.object(forKey: "pollution") == nil ||
            defaults.object(forKey: "socialImpact") == nil ||
            defaults.object(forKey: "currentlyGoing") == nil ||
            defaults.object(forKey: "budget") == nil {
            return false
        } else {
            return true
        }
    }
    
    static func saveBudget(budget: Int){
        let defaults = UserDefaults.standard
        defaults.set(budget, forKey: "budget")
    }


}
