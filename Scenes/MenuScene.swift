//
//  MenuScene.swift
//  
//
//  Created by luke-the-coder on 08/04/23.
//
import SpriteKit
import GameplayKit

class MenuScene: SKScene {

    // Instantiate a sprite node for the start button
    let startButton = SKSpriteNode(imageNamed: "PlayButton")
    let menuBackground = SKSpriteNode(imageNamed: "backgroundMenu1")
    
    
    override func didMove(to view: SKView) {
        // Position nodes from the center of the scene:
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Add the background image:
        menuBackground.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        menuBackground.setScale(1)
        menuBackground.position = CGPoint(x: 0, y: 0)
//        menuBackground.zRotation = CGFloat.pi / 2
        menuBackground.zPosition = -1
        self.addChild(menuBackground)

        // Build the start game button:
        startButton.size = CGSize(width: 500, height: 450)
        // Name the start node for touch detection:
        startButton.name = "startButton"
        startButton.position = CGPoint(x: 0, y: 0)
//        startButton.zRotation = CGFloat.pi / 2
        self.addChild(startButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "startButton" {
                // Player touched the start text or button node
                // Switch to an instance of the GameScene:
                self.view?.presentScene(GameScene(size: self.size), transition: SKTransition.fade(withDuration: 1))
                
            }
        }
    }
}

