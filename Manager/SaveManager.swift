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
        defaults.set(scene.score1, forKey: "score1")
        defaults.set(scene.score2, forKey: "score2")
        defaults.set(scene.currentlyGoing, forKey: "currentlyGoing")
        defaults.set(scene.budget, forKey: "budget")


        defaults.synchronize()
    }

    static func loadGameState(scene: GameScene) {
        let defaults = UserDefaults.standard
        scene.time = defaults.double(forKey: "time")
        scene.score1 = defaults.double(forKey: "score1")
        scene.score2 = defaults.double(forKey: "score2")
        scene.currentlyGoing = defaults.bool(forKey: "currentlyGoing")
        scene.budget = defaults.integer(forKey: "budget")

        
    }
    static func resetGameState() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "time")
        defaults.removeObject(forKey: "score1")
        defaults.removeObject(forKey: "score2")
        defaults.removeObject(forKey: "currentlyGoing")
        defaults.removeObject(forKey: "budget")
        defaults.synchronize()
    }
    
    static func isSaveDataAvailable() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "time") == nil ||
            defaults.object(forKey: "score1") == nil ||
            defaults.object(forKey: "score2") == nil ||
            defaults.object(forKey: "currentlyGoing") == nil ||
            defaults.object(forKey: "budget") == nil {
            return false
        } else {
            return true
        }
    }


}
