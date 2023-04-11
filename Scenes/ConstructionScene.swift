//
//  ConstructionScene.swift
//  
//
//  Created by luke-the-coder on 10/04/23.
//

import Foundation
import SpriteKit
import SwiftySKScrollView // Imported from https://github.com/crashoverride777/swifty-sk-scroll-view

class ConstructionScene: SKScene, SKPhysicsContactDelegate {
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    
    override func didMove(to view: SKView) {
        let backgroundNode = SKNode()
        
        let backgroundSprite = SKSpriteNode(imageNamed: "constructionScene")
        backgroundSprite.size = CGSize(width: frame.width, height: frame.height)
        backgroundSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.addChild(backgroundSprite)
        addChild(backgroundNode)

        let constructionButton = SKSpriteNode(imageNamed: "constructionButton")
        // Build the construction button:
        constructionButton.size = CGSize(width: 100, height: 80)
        // Name the start node for touch detection:
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: 80, y: 750)
        //startButton.zRotation = CGFloat.pi / 2
        self.addChild(constructionButton)
        
        
        
        

        setupHorizontalMenu()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "constructionButton" {
                // Player touched the start text or button node
                // Switch to an instance of the GameScene:
                deleteScrollView(from: view!)
                self.view?.presentScene(GameScene(size: self.size))
            }
        }
    }
    func deleteScrollView(from view: SKView) {
        scrollView?.removeFromSuperview()
        scrollView = nil // nil out reference to deallocate properly
    }
    
    func setupHorizontalMenu(){

        scrollView = SwiftySKScrollView(frame: CGRect(x: -frame.midX, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .horizontal)
        scrollView?.contentSize = CGSize(width: scrollView!.frame.width * 3, height: scrollView!.frame.height) // * 3 makes it three times as wide
        view?.addSubview(scrollView!)
        scrollView?.setContentOffset(CGPoint(x: 0 + scrollView!.frame.width * 2, y: 0), animated: true)
        moveableNode.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        moveableNode.position = CGPoint(x: -frame.midX, y: frame.midY/2)

        /// Test sprites page 1
        let sprite1 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: frame.midY/3))
        sprite1.position = CGPoint(x: -frame.midX*4+size.width/10, y: 0)
        moveableNode.addChild(sprite1)
                
        /// Test sprites page 2
        let sprite2 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: frame.midY/3))
        sprite2.position = CGPoint(x: -frame.midX*4+size.width/10*2, y: 0)
        moveableNode.addChild(sprite2)
                
        let sprite3 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: frame.midY/3))
        sprite3.position = CGPoint(x: -frame.midX*4+size.width/10*3, y: 0)
        moveableNode.addChild(sprite3)
        
        let sprite4 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: frame.midY/3))
        sprite4.position = CGPoint(x: -frame.midX*4+size.width/10*4, y: 0)
        moveableNode.addChild(sprite4)
    
        let sprite5 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: frame.midY/3))
        sprite5.position = CGPoint(x: -frame.midX*4+size.width/10*5, y: 0)
        moveableNode.addChild(sprite5)
        
        addChild(moveableNode)

    }
}
