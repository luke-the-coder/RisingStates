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
    var stateName : String = "ITALY"
    var score1: CGFloat = 0.1
    var score2: CGFloat = 2
    var budget : Int = 100
    var time: TimeInterval = 7
    var timer = Timer()
    lazy var pollutionBar = ProgressBar(barSize: CGSize(width: 200, height: 20), progress: score1, imageName: "pollutionProgressBar", title: "Pollution: ")
    lazy var socialImpactBar = ProgressBar(barSize: CGSize(width: 200, height: 20), progress: score2, imageName: "socialImpactProgessBar", title: "Social impact: ")
    
    var currentlyGoing : Bool = true
    let cam = SKCameraNode()
    var pauseButton = SKSpriteNode()
    var timeLabel = SKLabelNode()
    
    // Spawn rate for random events
    var eventHappening : Bool = false
    var lastTime:TimeInterval = 0.1
    var timeSinceRandomEvent :  TimeInterval = 0
    var spawnRateRandomEvents : TimeInterval = 60
    var randomEvent = SKNode()
    var blur = SKShapeNode(), rectangle = SKShapeNode()
    
    override func didMove(to view: SKView) {
        if(SaveManager.isSaveDataAvailable()){
            SaveManager.loadGameState(scene: self)
        }
        pollutionBar.updateBar(newValue: score1)
        socialImpactBar.updateBar(newValue: score2)
        self.view?.isMultipleTouchEnabled = true
        spawnBackground()
        displayTime()
        displayBudget()
        
        self.camera = cam
        
        
        pollutionBar.position = CGPoint(x: -frame.midX + pollutionBar.barSize.width - 20, y: frame.midY - pollutionBar.barSize.height/2 - 40)
        socialImpactBar.position = CGPoint(x: -frame.midX + socialImpactBar.barSize.width - 20, y: frame.midY - socialImpactBar.barSize.height/2 - 10)
        addChild(pollutionBar)
        addChild(socialImpactBar)
        
        pauseOrStop()
        
        
        checkConstruction()
        if events.first(where: { $0.name == "Introduction" }) != nil {
            intro()
        }
    }
    //background
    func spawnBackground(){
        let backgroundNode = SKNode()
        
        let backgroundSprite = SKSpriteNode(imageNamed: "backgroundItaly")
        backgroundSprite.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        backgroundSprite.position = CGPoint(x: 0, y: 0)
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundNode.addChild(backgroundSprite)
        
        let topHudSprite = SKSpriteNode(imageNamed: "topHud2")
        topHudSprite.size = CGSizeMake(self.frame.size.width, 80)
        topHudSprite.position = CGPoint(x: 0, y: self.frame.midY - topHudSprite.size.height/2)
        topHudSprite.zPosition = -99
        let stateNameLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        stateNameLabel.fontSize = 75
        stateNameLabel.fontColor = .black
        stateNameLabel.text = stateName
        stateNameLabel.horizontalAlignmentMode = .left
        stateNameLabel.verticalAlignmentMode = .center
        stateNameLabel.position = CGPoint(x: -stateNameLabel.frame.width/2 , y: frame.midY - stateNameLabel.frame.height/2 - 10)
        backgroundNode.addChild(stateNameLabel)
        backgroundNode.addChild(topHudSprite)
        
        let configuration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 100))
        
        let image = UIImage(systemName: "hammer.circle.fill", withConfiguration: configuration)
        image?.withTintColor(.gray)
        let Texture = SKTexture(image: image!)
        Texture.filteringMode = .linear
        let constructionButton = SKSpriteNode(texture: Texture)
        constructionButton.size = CGSize(width: 100, height: 100)
        constructionButton.anchorPoint = CGPoint(x: 0, y: 0)
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: -frame.midX + constructionButton.size.width/2, y: -frame.midY + constructionButton.size.height/2)
        backgroundNode.addChild(constructionButton)
        
        addChild(backgroundNode)
    }
    
    func pauseOrStop(){
        
        if(currentlyGoing){
            let Image = UIImage(systemName: "pause.circle")
            let Texture = SKTexture(image: Image!)
            Texture.filteringMode = .linear
            pauseButton = SKSpriteNode(texture: Texture)
        } else {
            let image = UIImage(systemName: "play.circle")
            let Texture = SKTexture(image: image!)
            Texture.filteringMode = .linear
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
                self.view?.presentScene(ConstructionScene(budget: self.budget, size: self.size), transition: SKTransition.fade(withDuration: 0.8))
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
                blur.removeFromParent()
                eventHappening = false
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    var isFirstUpdate = true
    override func update(_ currentTime: TimeInterval) {

        if !isFirstUpdate {
            checkRandomEvent(currentTime - lastTime)
        } else {
            isFirstUpdate = false
        }
        lastTime = currentTime
        
    }
    
    func displayBudget(){
        let budgetLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        budgetLabel.fontSize = 20
        budgetLabel.fontColor = .black
        budgetLabel.position = CGPoint(x: frame.midX - 150, y: frame.midY - 30)
        addChild(budgetLabel)
        budgetLabel.text = "Budget: " + String(budget) + "M"
    }
    func displayTime() {
        timeLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        var timeOfDay: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = dateFormatter.date(from: "2023/04/13")!
            let newDate = Calendar.current.date(byAdding: .day, value: Int(self.time), to: date)!
            return dateFormatter.string(from: newDate)
        }
        
        timeLabel.fontSize = 20
        timeLabel.fontColor = .black
        timeLabel.position = CGPoint(x: frame.midX - 140, y: frame.midY - frame.self.height/18)
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


    func checkConstruction() {
        for i in 0..<cards.count {
            if (cards[i].selected){
                if (!cards[i].changedStats){
                    pollutionBar.updateBarAddition(addend: cards[i].pollutionStats)
                    socialImpactBar.updateBarAddition(addend: -cards[i].socialImpact)
                    score1 += cards[i].pollutionStats
                    score2 -= cards[i].socialImpact
                    budget -= cards[i].budget
                    SaveManager.saveGameState(scene: self)
                    cards[i].changedStats = true
                }
                let buildingNode = SKSpriteNode(imageNamed: cards[i].spawningName)
                buildingNode.position = cards[i].position
                buildingNode.setScale(0.25)
                addChild(buildingNode)
                cards[i].spawned = true
            }
        }
    }
    func checkRandomEvent(_ frameRate:TimeInterval) {

        // add time to timer
        timeSinceRandomEvent += frameRate
        // return if it hasn't been enough time to fire laser
        if (timeSinceRandomEvent < spawnRateRandomEvents || eventHappening) {
            return
        }

        eventHappening = true
        blur = SKShapeNode(rectOf: CGSize(width: frame.midX*2, height: frame.midY*2))
        blur.alpha = CGFloat(0.8)
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
        
        let configuration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 200))

        let Image = UIImage(systemName: "checkmark.rectangle", withConfiguration: configuration)
        let Texture = SKTexture(image: Image!)
        Texture.filteringMode = .linear
        let confirmButton = SKSpriteNode(texture: Texture)
        confirmButton.zPosition = 12
        // Build the construction button:
        confirmButton.size = CGSize(width: 120, height: 100)
        // Name the start node for touch detection:
        confirmButton.anchorPoint = CGPoint(x: 0, y: 0)
        confirmButton.name = "readEvent"
        confirmButton.position = CGPoint(x: rectangle.position.x  - frame.midX/12, y: rectangle.position.y - frame.midY/2 + 10)
        //startButton.zRotation = CGFloat.pi / 2
        rectangle.addChild(confirmButton)
        if let event = events.randomElement() {
            // Create a node to display the event
            let eventNode = SKSpriteNode(imageNamed: event.imageName)
            eventNode.position = CGPoint(x: 0, y: 0)
            eventNode.zPosition = 11
            eventNode.size = CGSize(width: frame.width/2, height: frame.height/2)
            rectangle.addChild(eventNode)
            
        }
        
        
        timeSinceRandomEvent = 0
    }
    
    func intro(){
        blur = SKShapeNode(rectOf: CGSize(width: frame.midX*2, height: frame.midY*2))
        blur.alpha = CGFloat(0.8)
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
        Texture.filteringMode = .linear
        let confirmButton = SKSpriteNode(texture: Texture)
        confirmButton.zPosition = 12
        // Build the construction button:
        confirmButton.size = CGSize(width: 120, height: 100)
        // Name the start node for touch detection:
        confirmButton.anchorPoint = CGPoint(x: 0, y: 0)
        confirmButton.name = "readEvent"
        confirmButton.position = CGPoint(x: rectangle.position.x  - frame.midX/12, y: rectangle.position.y - frame.midY/2 + 10)
        //startButton.zRotation = CGFloat.pi / 2
        rectangle.addChild(confirmButton)
        let eventNode = SKSpriteNode(imageNamed: "randomEvent1")
        eventNode.position = CGPoint(x: 0, y: 0)
        //            eventNode.size = CGSize(width: rectangle.frame.size.width, height: rectangle.frame.size.height)
        rectangle.addChild(eventNode)
        if(!events.isEmpty){
            events.remove(at: 0)
        }
    }
    
    func presentGameOverScreen() {
            // Create an instance of the GameOverScene
            let gameOverScene = GameOverScene(size: self.size)
            // Set any properties on the GameOverScene as needed
            // ...
            // Present the GameOverScene
            self.view?.presentScene(gameOverScene)
        }
    
    
}
    


