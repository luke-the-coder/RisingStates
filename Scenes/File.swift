//
//  ConstructionScene.swift
//
//
//  Created by luke-the-coder on 10/04/23.
//

// OLD CONSTRUCTION SCENE, NEEDS TO BE DELETED

import Foundation
import SpriteKit

class test: SKScene, SKPhysicsContactDelegate {
    let cameraNode = SKCameraNode()
    let backgroundNode = SKNode()
    
    override func didMove(to view: SKView) {
        cameraNode.scene?.anchorPoint = CGPoint.zero
        self.camera = cameraNode
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanFrom(recognizer:)))
            panGestureRecognizer.maximumNumberOfTouches = 1
            view.addGestureRecognizer(panGestureRecognizer)
        
        
        
        let backgroundSprite = SKSpriteNode(imageNamed: "constructionScene")
        backgroundSprite.size = CGSize(width: frame.width, height: frame.height)
        backgroundSprite.position = CGPoint.zero
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        backgroundNode.addChild(backgroundSprite)
        addChild(backgroundNode)
        let Image = UIImage(systemName: "arrowshape.turn.up.backward.circle")
        let Texture = SKTexture(image: Image!)
        let constructionButton = SKSpriteNode(texture: Texture) // SKSpriteNode(imageNamed: "constructionButton")
        // Build the construction button:
        constructionButton.size = CGSize(width: 100, height: 100)
        constructionButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Name the start node for touch detection:
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: -frame.midX + constructionButton.size.width, y: frame.midY - constructionButton.size.height)
        //startButton.zRotation = CGFloat.pi / 2
        self.addChild(constructionButton)
        
        
        


        setupHorizontalMenu()
        
    }
    
    @objc func handlePanFrom(recognizer: UIPanGestureRecognizer) {
        if recognizer.state != .changed {
            return
        }

        // Get touch delta
        let translation = recognizer.translation(in: recognizer.view!)

        // Move camera
        if ((self.camera?.position.x)! < self.size.width * 3){
            self.camera?.position.x -= translation.x
            backgroundNode.position = cameraNode.position
        }
//        self.camera?.position.y += translation.y

        // Reset
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
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
                self.view?.presentScene(GameScene(size: self.size))
            }
            for cardName in cards {
                if (cardName.name == nodeTouched.name){
                    print("Yo this is it!")
                    print(cardName.name)
                }
            }
        }
    }
    
    
    func setupHorizontalMenu(){
        print("Frame.midX = " + String(Float(frame.midX)))
        print("Frame.midY = " + String(Float(frame.midY)))
        print("size.width = " + String(Float(size.width)))
        print("size.heigth = " + String(Float(size.height)))
//
//        let rectangle = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
//        rectangle.fillColor = .gray
//        rectangle.position = CGPoint(x: 0, y: 0)
//        rectangle.zPosition = 11
//        addChild(rectangle)
        /// Test sprites page 1
        let card1 = SKSpriteNode(imageNamed: "nuclearCard 1")
        card1.name = "Nuclear Power Plant"
//        card1.size = CGSize(width: 930, height: 691.22)
//        card1.position = CGPoint(x: -frame.midX*2+size.width/5, y: frame.midY/3 + 20)
        card1.position = CGPoint(x: 0, y: 0)

        addChild(card1)

        /// Test sprites page 2
        let card2 = SKSpriteNode(imageNamed: "educationCard")
//        card2.size = CGSize(width: 50, height: frame.midY/3)
//        card2.position = CGPoint(x: -frame.midX*4+size.width/5, y: frame.midY/3 + 20)
        card2.position = CGPoint(x: card2.size.width * 2, y: 0)

        addChild(card2)

        let card3 = SKSpriteNode(imageNamed: "coalCard")
        card3.name = "Coal Power Plant"
//        card2.size = CGSize(width: 50, height: frame.midY/3)
        card3.position = CGPoint(x: card3.size.width * 4 , y: -20)
        addChild(card3)
        
    }
}
