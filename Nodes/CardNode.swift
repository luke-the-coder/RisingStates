//
//  File.swift
//  
//
//  Created by luke-the-coder on 09/04/23.
//

import Foundation
import SpriteKit


class CardNode: SKSpriteNode {
    var isSelected = false
    
    // Add any necessary properties for the card data
    
    init() {
        let texture = SKTexture(imageNamed: "cardTexture")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = true
        // Change the appearance of the card to indicate that it has been selected
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Deselect the card
        isSelected = false
        // Reset the appearance of the card
    }
}

class FlashCardNode: SKSpriteNode {
    var frontText: String
    var isSelected = false
    
    init(frontText: String) {
        self.frontText = frontText
        let texture = SKTexture(imageNamed: "cardTexture")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        let labelNode = SKLabelNode(text: frontText)
        labelNode.fontSize = 24
        labelNode.fontName = "Helvetica"
        labelNode.position = CGPoint(x: 0, y: 0)
        addChild(labelNode)
        
        // Enable user interaction and set name
        isUserInteractionEnabled = true
        name = "flashCard"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // Calculate touch offset from card center
            let touchLocation = touch.location(in: parent!)
            let offset = CGPoint(x: touchLocation.x - position.x, y: touchLocation.y - position.y)
            // Store offset in user data
            userData = NSMutableDictionary()
            userData?.setValue(offset, forKey: "touchOffset")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // Calculate new card position based on touch position and touch offset
            let touchLocation = touch.location(in: parent!)
            let touchOffset = userData?.value(forKey: "touchOffset") as? CGPoint ?? CGPoint.zero
            position = CGPoint(x: touchLocation.x - touchOffset.x, y: touchLocation.y - touchOffset.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check if card is dropped in valid drop zone
        if let parentNode = parent, let touch = touches.first {
            let touchLocation = touch.location(in: parentNode)
            let dropZoneNodes = parentNode.nodes(at: touchLocation).filter { $0.name == "dropZone" }
            if let dropZoneNode = dropZoneNodes.first {
                // Card is dropped in valid drop zone, snap to center of drop zone
                position = dropZoneNode.position
            } else {
                // Card is dropped outside valid drop zone, snap back to original position
                position = userData?.value(forKey: "originalPosition") as? CGPoint ?? position
            }
        }
    }
}

