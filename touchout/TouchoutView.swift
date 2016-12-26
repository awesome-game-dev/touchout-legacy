import SpriteKit

@available(OSX 10.12.2, *)
class TouchoutView: SKView {
  // NOTE self-maintained currentScene, since the `scene` will not be updated during `makeTouchyBar`
  public var currentScene: TouchoutScene?
  public var menuScene: MenuScene?
  public var gameScene: GameScene?
  
  var parentViewController: NSViewController? {
    var parentResponder: NSResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.nextResponder
      if let viewController = parentResponder as? NSViewController {
        return viewController
      }
    }
    return nil
  }
  
  func switchScene(scene: TouchoutScene, transition: SKTransition?){
    NSLog("switching scene")
    var aTransition = transition
    if aTransition == nil {
      aTransition = SKTransition.crossFade(withDuration: 1)
      aTransition?.pausesOutgoingScene = true
      aTransition?.pausesIncomingScene = true
    }
    
    presentScene(scene, transition: aTransition!)
    
    currentScene = scene
    
    switch (currentScene?.name)! {
    case "MenuScene":
      menuScene = scene as! MenuScene
      gameScene = nil
    case "GameScene":
      gameScene = scene as! GameScene
      menuScene = nil
    default:
      break
    }
    
    // trigger touchbar re-building
    parentViewController?.touchBar = nil
  }
}
