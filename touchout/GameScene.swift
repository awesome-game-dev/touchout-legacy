// TODO group nodes

import SpriteKit
//import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    private struct CategoriesStruct {
        let ball : UInt32 = 0b1 << 0
        let border : UInt32 = 0b1 << 1
        let paddle : UInt32 = 0b1 << 2
        let abyss : UInt32 = 0b1 << 3
    }
    private let Categories = CategoriesStruct()
    // TODO hardcoding
    private let WIDTH = 1024
    private let HEIGHT = 768
    private var ballNode : SKSpriteNode?
    private var paddleNode : SKSpriteNode?
    private var fingerNode : SKNode?
    private var borderNode : SKNode?
    private var abyssNode : SKNode?
    private var trackingArea : NSTrackingArea?

    override func didMove(to view: SKView) {
        self.initEventsHandling()
        self.initPhysics()
        self.initBorders()
        self.initBall()
        self.initPaddle()
        self.initCollision()
    }

    override func willMove(from view: SKView) {
        self.removeEventsHandling()
    }

    private func initEventsHandling(){
        // init tracking area
        self.trackingArea = NSTrackingArea(rect: (view?.frame)!, options: [NSTrackingAreaOptions.mouseMoved, NSTrackingAreaOptions.activeInKeyWindow], owner: self, userInfo: nil)
        view?.addTrackingArea(self.trackingArea!)
    }

    private func removeEventsHandling(){
        view?.removeTrackingArea(self.trackingArea!)
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
        self.ballNode?.physicsBody!.applyImpulse(CGVector(dx: 200, dy: 200))
    }

    private func initPaddle(){
        // paddle node
        self.paddleNode = self.childNode(withName: "//paddleNode") as? SKSpriteNode // TODO optimize node searching
        let paddle = self.paddleNode!
        // finger node & physics body
        self.fingerNode = self.childNode(withName: "//fingerNode") // TODO optimize node searching
        let finger = self.fingerNode!
        finger.position = paddle.position
//        finger.physicsBody = SKPhysicsBody()
//        finger.physicsBody?.friction = 0
//        finger.physicsBody?.restitution = 1
//        finger.physicsBody?.linearDamping = 0
//        finger.physicsBody?.angularDamping = 0
    }
    
    private func initCollision(){
        self.ballNode?.physicsBody?.categoryBitMask = Categories.ball
        self.borderNode?.physicsBody?.categoryBitMask = Categories.border
        self.paddleNode?.physicsBody?.categoryBitMask = Categories.paddle
        self.abyssNode?.physicsBody?.categoryBitMask = Categories.abyss
        
        self.ballNode?.physicsBody?.collisionBitMask = Categories.border | Categories.paddle | Categories.abyss
        self.ballNode?.physicsBody?.contactTestBitMask = Categories.abyss
    }

    override func mouseMoved(with event: NSEvent) {
        // TODO hardcoding

        let touchingPos = event.location(in: self)

        // paddle moving
        let paddlePos = self.paddleNode!.position
        
        //   move abstract finger node
        self.fingerNode?.position.x = touchingPos.x

//        if (touchingPos.x < paddlePos.x) {
//        } else if (touchingPos.x > paddlePos.x) {
//        }
        self.paddleNode?.position.x = (self.fingerNode?.position.x)!
    }

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
    
//    override func update(_ currentTime: TimeInterval) {
//        print("update")
//    }

}
