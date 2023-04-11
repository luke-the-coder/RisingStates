//
//  GameScene.swift
//  
//
//  Created by luke-the-coder on 08/04/23.
//

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score1: CGFloat = 2
    var score2: CGFloat = 0.85
    var budgetText : String = ""
    var time: TimeInterval = 7
    var timer = Timer()
    lazy var pollutionBar = ProgressBar(barSize: CGSize(width: 200, height: 20), backgroundColor: .gray, progress: score1, imageName: "pollutionProgressBar")

    var currentlyGoing : Bool = true
    let cam = SKCameraNode()
    var pauseButton = SKSpriteNode()
    var timeLabel = SKLabelNode()
    
    // Spawn rate for random events
    var lastTime:TimeInterval = 0
    var timeSinceRandomEvent :TimeInterval = 0
    var spawnRateRandomEvents : TimeInterval = 60
    var randomEvent = SKNode()
    var blur = SKShapeNode(), rectangle = SKShapeNode()
    var firstEvent : Bool = true
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
        displayBudget()
    
        self.camera = cam

        
        pollutionBar.position = CGPoint(x: -frame.width/2 + pollutionBar.barSize.width/2 + 100, y: frame.height/2 - pollutionBar.barSize.height/2 - 10)
        addChild(pollutionBar)
        
        
        pauseOrStop()
        let Image = UIImage(systemName: "hammer.circle.fill")
        let Texture = SKTexture(image: Image!)

        let constructionButton = SKSpriteNode(texture: Texture)
        // Build the construction button:
        constructionButton.size = CGSize(width: 100, height: 100)
        // Name the start node for touch detection:
        constructionButton.anchorPoint = CGPoint(x: 0, y: 0)
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: -frame.midX + constructionButton.size.width/2, y: -frame.midY + constructionButton.size.height/2)
        //startButton.zRotation = CGFloat.pi / 2
        self.addChild(constructionButton)
        

    }
    func pauseOrStop(){
        
        if(currentlyGoing){
            let Image = UIImage(systemName: "pause.circle")
            let Texture = SKTexture(image: Image!)
            pauseButton = SKSpriteNode(texture: Texture)
        } else {
            let image = UIImage(systemName: "play.circle")
            let Texture = SKTexture(image: image!)
            pauseButton.removeFromParent()
            pauseButton = SKSpriteNode(texture: Texture)
        }
        pauseButton.size = CGSize(width: 50, height: 50)
        // Name the start node for touch detection:
        pauseButton.name = "pauseButton"
        pauseButton.position = CGPoint(x: frame.midX - pauseButton.frame.width*2/3, y: frame.midY - pauseButton.frame.height*2/3)
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
            print(nodeTouched)
            if nodeTouched.name == "constructionButton" {
                SaveManager.saveGameState(scene: self)
                timer.invalidate()
                self.view?.presentScene(ConstructionScene(size: self.size), transition: SKTransition.fade(withDuration: 0.8))
                let seconds = 0.8
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.removeAllChildren()
                }
            }
            else if nodeTouched.name == "pauseButton" {
                if(currentlyGoing){
                    timer.invalidate()
                    currentlyGoing.toggle()
                    pauseButton.removeFromParent()
                    pauseOrStop()
                } else {
                    currentlyGoing.toggle()
                    timeLabel.removeFromParent()
                    displayTime()
                    pauseButton.removeFromParent()
                    pauseOrStop()
                }
            }
            else if nodeTouched.name == "readEvent" {
                blur.removeAllChildren()
                rectangle.removeAllChildren()
                rectangle.removeFromParent()
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func update(_ currentTime: TimeInterval) {
//        pollutionBar.updateBar(newValue: CGFloat(1))
        checkRandomEvent(currentTime - lastTime)
        lastTime = currentTime
    }
    func displayBudget(){
        let budgetLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        budgetLabel.fontSize = 20
        budgetLabel.fontColor = .white
        budgetLabel.position = CGPoint(x: frame.midX - 150, y: frame.midY - 30)
        addChild(budgetLabel)
        budgetLabel.text = "Budget: 100M"
    }
    func displayTime() {
        
        timeLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        var timeOfDay: String {
            let hours = Int(self.time) % 24
            return String(format: "%02d:00", hours)
        }
    
        timeLabel.fontSize = 20 
        timeLabel.fontColor = .white
        timeLabel.position = CGPoint(x: frame.midX - frame.self.width/12, y: frame.midY - frame.self.height/18)
        addChild(timeLabel)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timers in
               guard let self = self else {
                   timers.invalidate()
                   return
               }
               self.time += 1
            self.timeLabel.text = timeOfDay
           }
        timer.tolerance = 0.1
        timer.fire()
    }
    
    func checkRandomEvent(_ frameRate:TimeInterval) {
        
        // add time to timer
        timeSinceRandomEvent += frameRate
        // return if it hasn't been enough time to fire laser
        if (timeSinceRandomEvent < spawnRateRandomEvents) {
            return
        }

        blur = SKShapeNode(rectOf: CGSize(width: frame.midX*2, height: frame.midY*2))
        blur.alpha = CGFloat(0.05)
        blur.fillColor = .gray
        blur.position = CGPoint(x: 0, y: 0)
        blur.zPosition = 10
        addChild(blur)


        
        // DO A RANDOM EVENT HERE
        rectangle = SKShapeNode(rectOf: CGSize(width: frame.width/2, height: frame.height/2))
        rectangle.fillColor = .gray
        rectangle.position = CGPoint(x: 0, y: 0)
        rectangle.zPosition = 11
        addChild(rectangle)
        
        let Image = UIImage(systemName: "checkmark.rectangle")
        let Texture = SKTexture(image: Image!)
        let confirmButton = SKSpriteNode(texture: Texture)
        confirmButton.zPosition = 12
        // Build the construction button:
        confirmButton.size = CGSize(width: 100, height: 100)
        // Name the start node for touch detection:
        confirmButton.anchorPoint = CGPoint(x: 0, y: 0)
        confirmButton.name = "readEvent"
        confirmButton.position = CGPoint(x: rectangle.position.x  - frame.midX/12, y: rectangle.position.y - frame.midY/2 + 10)
        //startButton.zRotation = CGFloat.pi / 2
        rectangle.addChild(confirmButton)
        if (firstEvent){
            let eventNode = SKSpriteNode(imageNamed: "randomEvent1")
            eventNode.position = CGPoint(x: 0, y: 0)
//            eventNode.size = CGSize(width: rectangle.frame.size.width, height: rectangle.frame.size.height)
            rectangle.addChild(eventNode)
            events.remove(at: 0)
        } else {
            if let event = events.randomElement() {
                // Create a node to display the event
                let eventNode = SKSpriteNode(imageNamed: event.imageName)
                eventNode.position = CGPoint(x: 0, y: 0)
                eventNode.zPosition = 11
                eventNode.size = CGSize(width: frame.width/2, height: frame.height/2)
                rectangle.addChild(eventNode)
            }
        }

        
        timeSinceRandomEvent = 0
        firstEvent = false
    }
    
}

