//
//  GameScene.swift
//  
//
//  Created by luke-the-coder on 08/04/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score1: CGFloat = 2
    var score2: CGFloat = 0.85
    var time: TimeInterval = 7
    var timer = Timer()
    lazy var pollutionBar = ProgressBar(barSize: CGSize(width: 200, height: 20), backgroundColor: .gray, progress: score1, imageName: "pollutionProgressBar")

    
    let cam = SKCameraNode()

    override func didMove(to view: SKView) {
        SaveManager.loadGameState(scene: GameScene(size: self.view!.bounds.size))
        self.view?.isMultipleTouchEnabled = true

        //background
        let backgroundNode = SKNode()
        
        let backgroundSprite = SKSpriteNode(imageNamed: "backgroundItaly")
        backgroundSprite.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        backgroundSprite.position = CGPoint(x: 0, y: 0)
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.addChild(backgroundSprite)
        
        let topHudSprite = SKSpriteNode(imageNamed: "topHud")
        topHudSprite.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        topHudSprite.position = CGPoint(x: 0, y: 0)
        topHudSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.addChild(topHudSprite)
        
        addChild(backgroundNode)

        displayTime()

        self.camera = cam

        
        pollutionBar.position = CGPoint(x: -frame.width/2 + pollutionBar.barSize.width/2 + 100, y: frame.height/2 - pollutionBar.barSize.height/2 - 10)


//        let publicOpinionBar = ProgressBar(barSize: CGSize(width: 200, height: 10), barColor: .blue, backgroundColor: .gray, progress: score2)
//        publicOpinionBar.position = CGPoint(x: -frame.width/2 + publicOpinionBar.barSize.width/2 + 130, y: frame.height/2 - publicOpinionBar.barSize.height/2 - 40)
//        publicOpinionBar.zPosition = 10
        addChild(pollutionBar)
//        addChild(publicOpinionBar)
        
        
        
        
        let constructionButton = SKSpriteNode(imageNamed: "constructionButton")
        // Build the construction button:
        constructionButton.size = CGSize(width: 100, height: 80)
        // Name the start node for touch detection:
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: -400, y: -350)
        //startButton.zRotation = CGFloat.pi / 2
        self.addChild(constructionButton)
        
        
        let pauseButton = SKSpriteNode(imageNamed: "pauseButton")
        // Build the construction button:
        pauseButton.size = CGSize(width: 50, height: 50)
        // Name the start node for touch detection:
        pauseButton.name = "pauseButton"
        pauseButton.position = CGPoint(x: frame.midX - pauseButton.frame.width*2/3, y: frame.midY - pauseButton.frame.height*2/3)
        //startButton.zRotation = CGFloat.pi / 2
        self.addChild(pauseButton)
    }
    
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "constructionButton" {
                SaveManager.saveGameState(scene: GameScene(size: self.view!.bounds.size))
                timer.invalidate()
                self.view?.presentScene(ConstructionScene(size: self.size), transition: SKTransition.fade(withDuration: 0.8))
                let seconds = 0.8
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.removeAllChildren()
                }
                
            }
            else if nodeTouched.name == "pauseButton" {
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func update(_ currentTime: TimeInterval) {
//        pollutionBar.updateBar(newValue: CGFloat(1))
    }
    
    func displayTime() {
        
        let timeLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        var timeOfDay: String {
            let hours = Int(self.time) % 24
            return String(format: "%02d:00", hours)
        }
    
        timeLabel.fontSize = 20 
        timeLabel.fontColor = .white
        timeLabel.position = CGPoint(x: frame.midX - frame.self.width/12, y: frame.midY - frame.self.height/20)
        addChild(timeLabel)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timers in
               guard let self = self else {
                   timers.invalidate()
                   return
               }
               self.time += 1
               timeLabel.text = timeOfDay
           }
        timer.tolerance = 0.1
        timer.fire()
    }
    
    // Called by the progress bar to update score1
        func updateScore1(newScore: CGFloat) {
            score1 = newScore
        }
        
        // Called by the progress bar to update score2
        func updateScore2(newScore: CGFloat) {
            score2 = newScore
        }
    
}

