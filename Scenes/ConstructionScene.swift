//
//  ConstructionScene.swift
//  
//
//  Created by luke-the-coder on 10/04/23.

import UIKit
import Foundation
import SpriteKit
import SwiftySKScrollView // Imported from https://github.com/crashoverride777/swifty-sk-scroll-view

class ConstructionScene: SKScene {
    let budgetLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
    let moveableNode = SKNode()
    var budget : Int
    
    init(budget: Int, size: CGSize) {
        self.budget = budget
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var scrollView: SwiftySKScrollView?
    
    override func didMove(to view: SKView) {
        addChild(SKAudioNode(fileNamed: "GameMusic.mp3"))
        addChild(moveableNode)

        let backgroundNode = SKNode()
        let backgroundSprite = SKSpriteNode(imageNamed: "constructionScene")
        backgroundSprite.size = CGSize(width: frame.width, height: frame.height)
        backgroundSprite.position = .zero
        backgroundSprite.zPosition = -100
        backgroundSprite.anchorPoint = .zero
        
        budgetLabel.fontSize = 50
        budgetLabel.fontColor = .white
        budgetLabel.position = CGPoint(x: frame.width - 200, y: frame.height - 60)
        addChild(budgetLabel)
        
        backgroundNode.addChild(backgroundSprite)
        addChild(backgroundNode)
        let Image = UIImage(systemName: "arrowshape.turn.up.backward.circle")
        let Texture = SKTexture(image: Image!)
        let constructionButton = SKSpriteNode(texture: Texture)
        constructionButton.size = CGSize(width: 100, height: 100)
        constructionButton.name = "constructionButton"
        constructionButton.position = CGPoint(x: constructionButton.size.width, y: frame.height - constructionButton.size.height)
        self.addChild(constructionButton)
        if scrollView == nil {
              setupHorizontalMenu()
          }
        
    }
    override func update(_ currentTime: TimeInterval) {
        budgetLabel.text = "Budget: " + String(self.budget) + "M"
    }
    
    let alert = SKSpriteNode(imageNamed: "noFundsAlert")
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "constructionButton" {
                self.view?.presentScene(GameScene(size: self.size), transition: .fade(withDuration: 0.5))
            } else if (nodeTouched.name == "alert") {
                alert.removeFromParent()
            }
            for i in 0..<cards.count {
                if (cards[i].name == nodeTouched.name){
                    if (self.budget >= cards[i].budget){
                        self.budget -= cards[i].budget
                        cards[i].count += 1
                        cards[i].selected = true
                    } else {
                        alert.position = CGPoint(x: frame.midX, y: frame.midY)
                        alert.name = "alert"
                        addChild(alert)
                    }
                }
            }
        }
    }

    override func willMove(from view: SKView) {
        scrollView?.removeFromSuperview()
        scrollView = nil
        moveableNode.removeAllChildren()
        moveableNode.removeFromParent()
        self.removeAllActions()
        self.removeAllChildren()
        self.enumerateChildNodes(withName: "*") { node, _ in
            node.removeFromParent()
        }
    }
    
    func setupHorizontalMenu(){
        scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .horizontal)
        scrollView?.contentSize = CGSize(width: scrollView!.frame.width*3, height: scrollView!.frame.height)
        view?.addSubview(scrollView!)
        scrollView?.setContentOffset(CGPoint(x: 110 + scrollView!.frame.width * 2, y: 0), animated: true)
        moveableNode.position = CGPoint(x: 0, y: scrollView!.frame.height / 2)
        var i = -8
        for card in cards {
            let cardNode = SKSpriteNode(imageNamed: card.imageName)
            cardNode.name = card.name
            cardNode.position = CGPoint(x: cardNode.size.width * CGFloat(i) + 15.0 * CGFloat(i), y: -60)
            i += 1
            moveableNode.addChild(cardNode)
        }
    }
}
