import SwiftUI
import SpriteKit

struct GameView: View {
    var menu: SKScene {
        let menu = MenuScene()
        menu.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        menu.scaleMode = .fill
        return menu
    }
    
    var body: some View {
        SpriteView(scene: self.menu, debugOptions: .showsPhysics).ignoresSafeArea()
    }
}
