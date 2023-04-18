import SwiftUI
import SpriteKit

struct GameView: View {
    var menu: SKScene {
        let menu = GameScene() //ConstructionScene(budget: 100, size: CGSize(width: 100, height: 100))// In reality it's MenuScene(), but it's easier to debug this way
        menu.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        menu.scaleMode = .resizeFill
        SaveManager.resetGameState()
        return menu
    }
    
    var body: some View {
        SpriteView(scene: self.menu, debugOptions: .showsNodeCount).ignoresSafeArea().statusBar(hidden: true)
    }
    
    
}

