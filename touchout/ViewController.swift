import Cocoa
import SpriteKit
//import GameplayKit

// TODO separate
class GameView: SKView {
    // NOTE self-maintained currentScene, since the `scene` will not be updated during `makeTouchyBar`
    public var currentScene: SKScene?

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

    func switchScene(scene: SKScene, transition: SKTransition?){
        var aTransition = transition
        if aTransition == nil {
            aTransition = SKTransition.crossFade(withDuration: 1)
            aTransition?.pausesOutgoingScene = true
            aTransition?.pausesIncomingScene = true
        }

        presentScene(scene, transition: aTransition!)

        currentScene = scene

        // trigger touchbar re-building
        if #available(OSX 10.12.2, *) {
            parentViewController?.touchBar = nil
        }
    }
}

class ViewController: NSViewController {

    @IBOutlet var skView: GameView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            view.showsFields = true

            let menuScene = SKScene(fileNamed: "MenuScene")!
            menuScene.scaleMode = .aspectFit
            view.switchScene(scene: menuScene, transition: nil)
        }
    }
}

@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    override func makeTouchBar() -> NSTouchBar? {
        guard let scene = skView.currentScene?.name else {
            return nil
        }

        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .mainBar
        touchBar.defaultItemIdentifiers = [.titleBtn, .otherItemsProxy]
        touchBar.customizationAllowedItemIdentifiers = [.titleBtn, .otherItemsProxy]
        touchBar.principalItemIdentifier = .titleBtn
        return touchBar

        print(scene)
        switch scene {
        case "MenuScene":
            print("making menu")
            return nil
        case "GameScene":
            print("making game")
            return nil
        default:
            return nil
        }
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItemIdentifier.titleBtn:
            let customViewItem = NSCustomTouchBarItem(identifier: identifier)
            customViewItem.view = NSButton(title: "Touchout", target: self, action: nil)
            return customViewItem
        case NSTouchBarItemIdentifier.menuStartBtn:
            let customViewItem = NSCustomTouchBarItem(identifier: identifier)
            customViewItem.view = NSButton(title: "Start", target: self, action: nil)
            return customViewItem
        default:
            let customViewItem = NSCustomTouchBarItem(identifier: identifier)
            customViewItem.view = NSButton(title: "Other", target: self, action: nil)
            return customViewItem
//            return nil
        }
    }
}
