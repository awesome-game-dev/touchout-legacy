import Cocoa
import SpriteKit
//import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            let menuScene = SKScene(fileNamed: "MenuScene")!
            menuScene.scaleMode = .aspectFit
            view.presentScene(menuScene)

            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
}

@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .menuBar
        touchBar.defaultItemIdentifiers = [.menuBarStartBtn]
        touchBar.customizationAllowedItemIdentifiers = [.menuBarStartBtn]
        return touchBar
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItemIdentifier.menuBarStartBtn:
            let customViewItem = NSCustomTouchBarItem(identifier: identifier)
            customViewItem.view = NSButton(title: "Start", target: self, action: nil)
            return customViewItem
        default:
            return nil
        }
    }
}
