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
