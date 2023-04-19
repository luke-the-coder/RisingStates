import SwiftUI
import SpriteKit

struct GameView: View {
    var menu: SKScene {
        let menu = GameScene()
        menu.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        menu.scaleMode = .resizeFill
        SaveManager.resetGameState()
        return menu
    }
    
    var body: some View {
        SpriteView(scene: self.menu).ignoresSafeArea().statusBar(hidden: true)
    }
    
    
}

