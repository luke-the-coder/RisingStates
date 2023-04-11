//
//  ProgressBarNode.swift
//  
//
//  Created by luke-the-coder on 09/04/23.
//

import Foundation
import SpriteKit

class ProgressBar: SKNode {
    var barSize: CGSize
    var backgroundColor: UIColor
    var progress: CGFloat
    var imageName : String
    init(barSize: CGSize, backgroundColor: UIColor, progress: CGFloat, imageName : String) {
        self.barSize = barSize
        self.backgroundColor = backgroundColor
        self.imageName = imageName
        self.progress = progress
        super.init()
        
        createProgressBar()
    }
    let cropNode = SKCropNode()
    var maskNode = SKSpriteNode()
    var progressBar = SKSpriteNode()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBar(newValue: CGFloat) {
        if(newValue >= CGFloat(2)){
            return
        }
        maskNode.xScale = newValue

    }
    
    private func createProgressBar(){
        // Create the progress bar sprite node
        progressBar = SKSpriteNode(imageNamed: "pollutionProgressBar1")
        progressBar.size = self.barSize
        progressBar.position = CGPoint(x: 0, y: 0)
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        cropNode.addChild(progressBar)

        maskNode = SKSpriteNode(color: SKColor.white, size: barSize)
        maskNode.xScale = progress
        cropNode.maskNode = maskNode
        self.addChild(cropNode)

    }
    

    
}
