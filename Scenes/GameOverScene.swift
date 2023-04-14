//
//  GameOverScene.swift
//  
//
//  Created by luke-the-coder on 14/04/23.
//
import SpriteKit
class GameOverScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        // Set up your game over screen here
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontSize = 48
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(gameOverLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
