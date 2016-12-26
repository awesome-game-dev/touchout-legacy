import SpriteKit
//import GameplayKit

@available(OSX 10.12.2, *)
class MenuScene: TouchoutScene {
    override func didMove(to view: SKView) {
    }

    override func mouseUp(with event: NSEvent) {
        handleStartBtnOnClick()
    }

    public func handleStartBtnOnTouch(){
        handleStartBtnOnClick()
    }

    private func handleStartBtnOnClick(){
        let gameScene = TouchoutScene(fileNamed: "GameScene")!
        gameScene.scaleMode = .aspectFit
        
        let reveal = SKTransition.crossFade(withDuration: 1)
        reveal.pausesOutgoingScene = true
        reveal.pausesIncomingScene = true
        
        (self.view as! TouchoutView).switchScene(scene: gameScene, transition: reveal)
    }
}

// touchbar related
@available(OSX 10.12.2, *)
extension MenuScene {
  override func buildTouchBar() -> NSTouchBar {
    let touchBar = NSTouchBar()
    touchBar.delegate = self
    touchBar.customizationIdentifier = .menuBar
    touchBar.defaultItemIdentifiers = [.titleSpan, .menuStartBtn]
    touchBar.customizationAllowedItemIdentifiers = [.titleSpan, .menuStartBtn]
    touchBar.principalItemIdentifier = .menuStartBtn
    return touchBar
  }
  
  func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
    switch identifier {
    case NSTouchBarItemIdentifier.titleSpan:
      // TODO style
      let item = NSCustomTouchBarItem(identifier: identifier)
      item.view = NSButton(title: "Touchout", target: self, action: nil)
      return item
    case NSTouchBarItemIdentifier.menuStartBtn:
      // TODO style
      let item = NSCustomTouchBarItem(identifier: identifier)
      item.view = NSButton(title: "Start", target: self, action: #selector(handleStartBtnOnTouch))
      return item
    default:
      return nil
    }
  }

}
