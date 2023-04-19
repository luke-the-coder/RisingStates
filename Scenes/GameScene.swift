//
//  GameScene.swift
//  
//
//  Created by luke-the-coder on 08/04/23.
//

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    let menuBackground = SKSpriteNode(imageNamed: "backgroundMenu1")
    let startButton = SKSpriteNode(imageNamed: "PlayButton")
    
    var stateName : String = "ITALY"
    var pollution: CGFloat = 1.4
    var socialImpact: CGFloat = 2
    var budget : Int = 100
    var time: TimeInterval = 7
    var timer = Timer()
    lazy var pollutionBar = ProgressBar(barSize: CGSize(width: 200, height: 20), progress: pollution, imageName: "pollutionProgressBar", title: "Pollution: ")
    lazy var socialImpactBar = ProgressBar(barSize: CGSize(width: 200, height: 20), progress: socialImpact, imageName: "socialImpactProgessBar", title: "Social impact: ")
    
    var currentlyGoing : Bool = true
    let cam = SKCameraNode()
    var pauseButton = SKSpriteNode()
    var timeLabel = SKLabelNode()
    
    // Spawn rate for random events
    var eventHappening : Bool = false
    var lastTime:TimeInterval = 0.1
    var timeSinceRandomEvent :  TimeInterval = 0
    var spawnRateRandomEvents : TimeInterval = 30
    var randomEvent = SKNode()
    var rectangle = SKShapeNode()
    
    var showingMenu : Bool = true
    override func didMove(to view: SKView) {
        if(SaveManager.isSaveDataAvailable()){
            SaveManager.loadGameState(scene: self)
        }
        if(showingMenu){
            showMenu()
            return
        }
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(SKAudioNode(fileNamed: "GameMusic.mp3"))
 
        pollutionBar.updateBar(newValue: pollution)
        socialImpactBar.updateBar(newValue: socialImpact)
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
    let menuAudio = SKAudioNode(fileNamed: "MenuMusic.mp3")
    func showMenu(){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuBackground.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
        menuBackground.setScale(1)
        menuBackground.position = CGPoint(x: 0, y: 0)
        menuBackground.zPosition = 1000
        self.addChild(menuBackground)

        startButton.setScale(0.5)
        startButton.name = "startButton"
        startButton.zPosition = 1000
        startButton.position = CGPoint(x: 0, y: 0)
        self.addChild(startButton)
        self.addChild(menuAudio)
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
        pauseButton.name = "pauseButton"
        pauseButton.position = CGPoint(x: frame.midX - pauseButton.frame.width*2/3, y: frame.midY - pauseButton.frame.height*2/3)
        self.addChild(pauseButton)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {}
    func touchMoved(toPoint pos : CGPoint) {}
    func touchUp(atPoint pos : CGPoint) {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "constructionButton" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.removeAllActions()
                    self.enumerateChildNodes(withName: "*") { node, _ in
                        node.removeFromParent()
                    }
                    self.removeAllChildren()
                }
                SaveManager.saveGameState(scene: self)
                timer.invalidate()
                self.scene?.removeFromParent()
                self.view?.presentScene(ConstructionScene(budget: self.budget, size: self.size), transition: SKTransition.fade(withDuration: 0.8))
            } else if nodeTouched.name == "startButton" {
                menuBackground.removeFromParent()
                startButton.removeFromParent()
                menuAudio.removeFromParent()
                showingMenu = false
                didMove(to: self.view!)
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
            } else if nodeTouched.name == "readEvent" {
                blur.removeAllChildren()
                rectangle.removeAllChildren()
                rectangle.removeFromParent()
                blur.removeFromParent()
                eventHappening = false
            } else if nodeTouched.name == "restart" {
                resetCards()
                self.enumerateChildNodes(withName: "building") { node, _ in
                    node.removeFromParent()
                }
                SaveManager.resetGameState()
                gameOverOn = false
                pollution = 0.1
                socialImpact = 2
                budget = 100
                budgetLabel.removeFromParent()
                survivedText.removeFromParent()
                displayBudget()
                pauseButton.removeFromParent()
                pauseOrStop()
                pollutionBar.updateBar(newValue: pollution)
                socialImpactBar.updateBar(newValue: socialImpact)
                removeGameOver()
            }
        }
    }
    
    var isFirstUpdate = true
    var gameOverOn = false
    override func update(_ currentTime: TimeInterval) {
        if !isFirstUpdate {
            checkRandomEvent(currentTime - lastTime)
        } else {
            isFirstUpdate = false
        }
        if (!gameOverOn){
            checkGameOver()
        }
        lastTime = currentTime
    }
    
    func checkGameOver(){
        if (pollution >= 2 || socialImpact <= 0){
            gameOverOn = true
            presentGameOverScreen()
        }
    }
    var budgetLabel = SKLabelNode( fontNamed: "GillSans-SemiBoldItalic")
    func displayBudget(){
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
            let date = Date()
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
    
    var buildingNode = SKSpriteNode()
    func checkConstruction() {
        for i in 0..<cards.count {
            if (cards[i].selected){
                if (!cards[i].changedStats){
                    pollutionBar.updateBarAddition(addend: cards[i].pollutionStats)
                    socialImpactBar.updateBarAddition(addend: -cards[i].socialImpact)
                    pollution += cards[i].pollutionStats
                    socialImpact -= cards[i].socialImpact
                    updateBudget(addition: -cards[i].budget)
                    SaveManager.saveGameState(scene: self)
                    cards[i].changedStats = true
                }
                buildingNode = SKSpriteNode(imageNamed: cards[i].spawningName)
                buildingNode.position = cards[i].position
                buildingNode.setScale(0.25)
                buildingNode.name = "building"
                addChild(buildingNode)
                cards[i].spawned = true
            }
        }
    }
    
    func updateBudget(addition : Int){
        budget += addition
        budgetLabel.removeFromParent()
        displayBudget()
    }
    func checkRandomEvent(_ frameRate:TimeInterval) {
        timeSinceRandomEvent += frameRate
        if (timeSinceRandomEvent < spawnRateRandomEvents || eventHappening || gameOverOn) {
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
        confirmButton.size = CGSize(width: 120, height: 100)
        confirmButton.anchorPoint = CGPoint(x: 0, y: 0)
        confirmButton.name = "readEvent"
        confirmButton.position = CGPoint(x: rectangle.position.x  - frame.midX/12, y: rectangle.position.y - frame.midY/2 + 10)
        rectangle.addChild(confirmButton)
        if let event = events.randomElement() {
            let eventNode = SKSpriteNode(imageNamed: event.imageName)
            eventNode.position = CGPoint(x: 0, y: 0)
            eventNode.zPosition = 11
            eventNode.size = CGSize(width: frame.width/2, height: frame.height/2)
            rectangle.addChild(eventNode)
            updateBudget(addition: event.budget)
            pollutionBar.updateBarAddition(addend: event.pollutionStats)
            socialImpactBar.updateBarAddition(addend: event.socialImpact)

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
        confirmButton.size = CGSize(width: 120, height: 100)
        confirmButton.anchorPoint = CGPoint(x: 0, y: 0)
        confirmButton.name = "readEvent"
        confirmButton.position = CGPoint(x: rectangle.position.x  - frame.midX/12, y: rectangle.position.y - frame.midY/2 + 10)
        rectangle.addChild(confirmButton)
        let eventNode = SKSpriteNode(imageNamed: "randomEvent1")
        eventNode.position = CGPoint(x: 0, y: 0)
        rectangle.addChild(eventNode)
        if(!events.isEmpty){
            events.remove(at: 0)
        }
    }
    var blur = SKShapeNode()
    var restartButton = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    var survivedText = SKLabelNode()
    func presentGameOverScreen() {
        blur = SKShapeNode(rectOf: CGSize(width: frame.midX*2, height: frame.midY*2))
        blur.alpha = CGFloat(0.8)
        blur.fillColor = .gray
        blur.position = CGPoint(x: 0, y: 0)
        addChild(blur)
        
        restartButton = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        restartButton.text = "Restart"
        restartButton.name = "restart"
        restartButton.fontSize = 60
        restartButton.fontColor = .white
        restartButton.position = CGPoint(x: 0, y: -80)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let timeLabelDate = dateFormatter.date(from: self.timeLabel.text!)!
        let currentDate = Date()
        let timeSurvived = Int(currentDate.timeIntervalSince(timeLabelDate))
        let daysSurvived = -Int(timeSurvived / (24 * 60 * 60))

        survivedText = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        survivedText.text = "You survived for \(daysSurvived) days"
        survivedText.fontSize = 60
        survivedText.fontColor = .white
        survivedText.position = CGPoint(x: 0, y: -160)
        addChild(survivedText)
        addChild(restartButton)
        
        // Create a label node for "Game Over" text
        gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontName = "GillSans-SemiBoldItalic"
        gameOverLabel.fontSize = 72
        gameOverLabel.position = CGPoint.zero
        gameOverLabel.alpha = 0.0
        addChild(gameOverLabel)
        
        // Create a sequence of actions to animate the game over
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let sequence = SKAction.sequence([fadeIn])
        gameOverLabel.run(sequence)
        restartButton.run(sequence)
        
        timer.invalidate()
    }
    
    func removeGameOver(){
        blur.removeFromParent()
        restartButton.removeFromParent()
        gameOverLabel.removeFromParent()
    }
}
