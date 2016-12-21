import SpriteKit
//import GameplayKit

class MenuScene: SKScene {
    override func mouseUp(with event: NSEvent) {
        let gameScene = SKScene(fileNamed: "GameScene")!
        gameScene.scaleMode = .aspectFit

        let reveal = SKTransition.crossFade(withDuration: 1)
        reveal.pausesOutgoingScene = true
        reveal.pausesIncomingScene = true

        self.view?.presentScene(gameScene, transition: reveal)
    }
}
