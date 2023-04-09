//
//  File.swift
//  
//
//  Created by luke-the-coder on 08/04/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    let cam = SKCameraNode()
    //TEMPO
    let timeLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
      var time: TimeInterval = 7
      var timeOfDay: String {
          let hours = Int(time) % 24
          let minutes = Int((time - TimeInterval(hours)) * 60)
          return String(format: "%02d:00", hours)
      }
    
    override func didMove(to view: SKView) {
        
        
        //background
        let backgroundNode = SKNode()

        let backgroundSprite = SKSpriteNode(imageNamed: "backgroundItaly")
        backgroundSprite.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        backgroundSprite.position = CGPoint(x: 0, y: 0)
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        backgroundNode.addChild(backgroundSprite)

        let rotation = SKAction.rotate(byAngle: CGFloat.pi/4, duration: 0)
//        backgroundNode.zRotation = -CGFloat.pi / 2

//        backgroundNode.run(rotation)

        addChild(backgroundNode)

        
        timeLabel.fontSize = 24
               timeLabel.fontColor = .white
               timeLabel.position = CGPoint(x: 0, y: 50)
               addChild(timeLabel)
               
               let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                   guard let self = self else { return }
                   self.time += 1
                   self.timeLabel.text = self.timeOfDay
               }
               timer.tolerance = 0.1
               timer.fire()
        // Get the size of the scene
        let sceneSize = size
        
        // Create banner node
        let bannerNode = SKSpriteNode(color: .red, size: CGSize(width: sceneSize.width, height: 100))
        bannerNode.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height - bannerNode.size.height/2)
        bannerNode.zPosition = 1
        addChild(bannerNode)
        
        // Create title label node
        let titleLabelNode = SKLabelNode(text: "Italy")
        titleLabelNode.fontSize = 36
        titleLabelNode.fontName = "Helvetica-Bold"
        titleLabelNode.fontColor = .white
        titleLabelNode.position = CGPoint(x: bannerNode.size.width/2, y: bannerNode.size.height/2)
        bannerNode.addChild(titleLabelNode)
        
        
        
        self.camera = cam
        self.view?.isMultipleTouchEnabled = true
//        anchorPoint = CGPoint(x: 0, y: 0)
//        self.addChild(cam)
        
        let card1 = FlashCardNode(frontText: "test1")
        card1.position = CGPoint(x: 100, y: 100)
        addChild(card1)
        
        let card2 = FlashCardNode(frontText: "test2")
        card2.position = CGPoint(x: 200, y: 100)
        addChild(card2)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func update(_ currentTime: TimeInterval) {
    }
    
}

