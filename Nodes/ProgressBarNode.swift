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
    var progress: CGFloat
    var imageName : String
    var title : String
    init(barSize: CGSize, progress: CGFloat, imageName : String, title: String) {
        self.barSize = barSize
        self.imageName = imageName
        self.progress = progress
        self.title = title
        super.init()
        createProgressBar()
    }
    
    let cropNode = SKCropNode()
    var maskNode = SKSpriteNode()
    var progressBar = SKSpriteNode()
    var progressBarLabel = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBar(newValue: CGFloat) {
        var value = newValue
        if(newValue >= CGFloat(2)){
            value = 2
        }
        maskNode.xScale = value
    }
    
    func updateBarAddition(addend: CGFloat) {
        var newValue = addend + maskNode.xScale
        if(newValue >= CGFloat(2)){
            newValue = 2
        }
        maskNode.xScale = newValue
    }
    
    private func createProgressBar(){
        // Create the progress bar sprite node
        progressBar = SKSpriteNode(imageNamed: imageName)
        progressBar.size = self.barSize
        progressBar.position = CGPoint(x: 0, y: 0)
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        cropNode.addChild(progressBar)

        maskNode = SKSpriteNode(color: SKColor.white, size: barSize)
        maskNode.xScale = progress
        cropNode.maskNode = maskNode
        
        progressBarLabel = SKLabelNode(fontNamed: "GillSans-SemiBoldItalic")
        progressBarLabel.fontSize = 20
        progressBarLabel.fontColor = .black
        progressBarLabel.text = title
        progressBarLabel.horizontalAlignmentMode = .left
        progressBarLabel.verticalAlignmentMode = .center
        progressBarLabel.position = CGPoint(x: -frame.midX - 140 , y: 3)
        self.addChild(progressBarLabel)

        self.addChild(cropNode)

    }
    

    
}
