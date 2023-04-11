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

//        defaults.set(scene.score1, forKey: "score1")

//        if let playerPosition = scene.playerNode?.position {
//            let positionData = NSKeyedArchiver.archivedData(withRootObject: playerPosition)
//            defaults.set(positionData, forKey: "playerPosition")
//        }

        defaults.synchronize()
    }

    static func loadGameState(scene: GameScene) {
        let defaults = UserDefaults.standard
        scene.time = defaults.double(forKey: "time")
        scene.score1 = defaults.double(forKey: "score1")
        scene.score2 = defaults.double(forKey: "score2")

//        scene.score1 = defaults.float (forKey: "score1")

//        if let positionData = defaults.object(forKey: "playerPosition") as? Data,
//           let playerPosition = NSKeyedUnarchiver.unarchiveObject(with: positionData) as? CGPoint {
//            scene.playerNode?.position = playerPosition
//        }
    }
}
