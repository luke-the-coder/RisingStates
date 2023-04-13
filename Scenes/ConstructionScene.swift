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
        backgroundSprite.position = .zero
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = .zero
        
        backgroundNode.addChild(backgroundSprite)
        addChild(backgroundNode)
        let Image = UIImage(systemName: "arrowshape.turn.up.backward.circle")
        let Texture = SKTexture(image: Image!)
        let constructionButton = SKSpriteNode(texture: Texture) // SKSpriteNode(imageNamed: "constructionButton")
        // Build the construction button:
        constructionButton.size = CGSize(width: 100, height: 100)
        // Name the start node for touch detection:
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: constructionButton.size.width, y: frame.height - constructionButton.size.height)
        self.addChild(constructionButton)

        setupHorizontalMenu()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            print(nodeTouched)

            if nodeTouched.name == "constructionButton" {
                // Player touched the start text or button node
                // Switch to an instance of the GameScene:
                deleteScrollView(from: view!)
                self.view?.presentScene(GameScene(size: self.size))
            }
            for cardName in cards {
                if (cardName.name == nodeTouched.name){
                    print(cardName.name)
                }
            }
        }
    }
    func deleteScrollView(from view: SKView) {
        scrollView?.removeFromSuperview()
        scrollView = nil // nil out reference to deallocate properly
    }
    
    
    func setupHorizontalMenu(){
        scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .horizontal)
        scrollView?.contentSize = CGSize(width: scrollView!.frame.width*3, height: scrollView!.frame.height) // * 3 makes it three times as wide
        view?.addSubview(scrollView!)
        scrollView?.setContentOffset(CGPoint(x: 0 + scrollView!.frame.width * 2, y: 0), animated: true)
        moveableNode.position = CGPoint(x: 0, y: scrollView!.frame.height / 2)
        var i = -8
        for card in cards {
            let cardNode = SKSpriteNode(imageNamed: card.imageName)
            cardNode.name = card.name
            cardNode.position = CGPoint(x: cardNode.size.width * CGFloat(i) , y: -60)
            i += 1
            moveableNode.addChild(cardNode)
        }
        
        addChild(moveableNode)

    }
}
