//
//  GameOverScene.swift
//  
//
//  Created by luke-the-coder on 14/04/23.
//
import SpriteKit
class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.view?.presentScene( GameScene(size: self.size), transition: .crossFade(withDuration: 1.5))
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontSize = 48
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(gameOverLabel)
    }
}
