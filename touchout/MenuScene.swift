import SpriteKit
//import GameplayKit

@available(OSX 10.12.2, *)
class MenuScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func mouseUp(with event: NSEvent) {
        handleStartBtnOnClick()
    }

    public func handleStartBtnOnTouch(){
        handleStartBtnOnClick()
    }

    private func handleStartBtnOnClick(){
        let gameScene = SKScene(fileNamed: "GameScene")!
        gameScene.scaleMode = .aspectFit
        
        let reveal = SKTransition.crossFade(withDuration: 1)
        reveal.pausesOutgoingScene = true
        reveal.pausesIncomingScene = true
        
        (self.view as! TouchoutView).switchScene(scene: gameScene, transition: reveal)
    }
}
