// TODO group nodes

import SpriteKit
//import GameplayKit

@available(OSX 10.12.2, *)
class GameScene: TouchoutScene {
  
  struct CategoriesStruct {
    let ball : UInt32 = 0b1 << 0
    let border : UInt32 = 0b1 << 1
    let paddle : UInt32 = 0b1 << 2
    let abyss : UInt32 = 0b1 << 3
    let bricks : UInt32 = 0b1 << 4
  }
  let Categories = CategoriesStruct()

  // TODO hardcoding
  let WIDTH = 1024
  let HEIGHT = 768
  var ballNode : SKSpriteNode?
  var paddleNode : SKSpriteNode?
  var fingerNode : SKNode?
  var borderNode : SKNode?
  var abyssNode : SKNode?
  
  private var trackingArea : NSTrackingArea?

  override func didMove(to view: SKView) {
    initEventsHandling()
    initPhysics()
    initBorders()
    initBall()
    initPaddle()
    initBricks()
    initCollision()
  }
  
  override func willMove(from view: SKView) {
    destroyEventsHandling()
  }
  
  private func initEventsHandling(){
    initTrackingArea()
  }
  
  private func initTrackingArea(){
    self.trackingArea = NSTrackingArea(rect: (view?.frame)!, options: [NSTrackingAreaOptions.mouseMoved, NSTrackingAreaOptions.activeInKeyWindow], owner: self, userInfo: nil)
    view?.addTrackingArea(trackingArea!)
  }
  
  private func destroyEventsHandling(){
    if (self.trackingArea != nil) {
      view?.removeTrackingArea(self.trackingArea!)
    }
  }
  
  private func initPhysics(){
    self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    self.physicsWorld.contactDelegate = self // TODO separate delegate class
  }
  
  private func initBorders(){
    let borderNode = SKNode()
    borderNode.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    borderNode.physicsBody?.friction = 0
    borderNode.physicsBody?.restitution = 1
    borderNode.physicsBody?.linearDamping = 0
    borderNode.physicsBody?.angularDamping = 0
    self.borderNode = borderNode
    self.addChild(self.borderNode!)
    
    // abyssNode
    let abyssNode = SKNode()
    abyssNode.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.WIDTH/2, y: -self.HEIGHT/2), to: CGPoint(x: self.WIDTH/2, y: -self.HEIGHT/2))
    abyssNode.physicsBody?.friction = 0
    abyssNode.physicsBody?.friction = 0
    abyssNode.physicsBody?.restitution = 1
    abyssNode.physicsBody?.linearDamping = 0
    abyssNode.physicsBody?.angularDamping = 0
    self.abyssNode = abyssNode
    
    self.addChild(self.abyssNode!)
  }
  
  private func initBall(){
    self.ballNode = self.childNode(withName: "//ballNode") as? SKSpriteNode // TODO optimize node searching
    self.ballNode?.physicsBody!.applyImpulse(CGVector(dx: 400, dy: 400))
  }
  
  private func initPaddle(){
    // paddle node
    self.paddleNode = self.childNode(withName: "//paddleNode") as? SKSpriteNode // TODO optimize node searching
    let paddle = self.paddleNode!
    // finger node & physics body
    self.fingerNode = self.childNode(withName: "//fingerNode") // TODO optimize node searching
    let finger = self.fingerNode!
    finger.position = paddle.position
  }

  private func initBricks(){
    
  }

  private func initCollision(){
    self.ballNode?.physicsBody?.categoryBitMask = Categories.ball
    self.borderNode?.physicsBody?.categoryBitMask = Categories.border
    self.paddleNode?.physicsBody?.categoryBitMask = Categories.paddle
    self.abyssNode?.physicsBody?.categoryBitMask = Categories.abyss
//    self.brick

    self.ballNode?.physicsBody?.collisionBitMask = Categories.border | Categories.paddle | Categories.abyss
    self.ballNode?.physicsBody?.contactTestBitMask = Categories.abyss
  }
  
  override func mouseMoved(with event: NSEvent) {
    // TODO hardcoding
    
    let touchingPos = event.location(in: self)
    
    // paddle moving
    //        let paddlePos = self.paddleNode!.position
    
    //   move abstract finger node
    self.fingerNode?.position.x = touchingPos.x
    
    //        if (touchingPos.x < paddlePos.x) {
    //        } else if (touchingPos.x > paddlePos.x) {
    //        }
    self.paddleNode?.position.x = (self.fingerNode?.position.x)!
  }
  
  //    override func update(_ currentTime: TimeInterval) {
  //        print("update")
  //    }
}

@available(OSX 10.12.2, *)
extension GameScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {
    var firstBody: SKPhysicsBody
    var secondBody: SKPhysicsBody
    
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    } else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }
    
    if firstBody.categoryBitMask == Categories.ball && secondBody.categoryBitMask == Categories.abyss {
      print("hit bottom")
      self.isPaused = true
    }
  }
}

// touchbar related
@available(OSX 10.12.2, *)
extension GameScene {
  override func buildTouchBar() -> NSTouchBar {
    let touchBar = NSTouchBar()
    touchBar.delegate = self
    touchBar.customizationIdentifier = .gameBar
    touchBar.defaultItemIdentifiers = [.titleSpan, .gamePaddleSlider]
    touchBar.customizationAllowedItemIdentifiers = [.titleSpan, .gamePaddleSlider]
    touchBar.principalItemIdentifier = .gamePaddleSlider
    return touchBar
  }
  
  func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
    switch identifier {
    case NSTouchBarItemIdentifier.gamePaddleSlider:
      // TODO style
      let item = NSSliderTouchBarItem(identifier: identifier)
      let slider = NSSlider(target: nil, action: nil)
      slider.isContinuous = true
      item.slider = slider
      item.label = "Paddle"
      item.target = self
      item.action = #selector(handleSliderOnTouch)
      return item
    default:
      return nil
    }
  }

  func handleSliderOnTouch(sender: NSSliderTouchBarItem) {
    let sliderValue = sender.slider.doubleValue
    // TODO
    let projectedPosX = sliderValue * Double(WIDTH) - Double(WIDTH / 2)
    self.paddleNode?.position.x = CGFloat(projectedPosX)
  }
}
