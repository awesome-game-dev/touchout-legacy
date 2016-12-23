import Cocoa
import SpriteKit
//import GameplayKit

@available(OSX 10.12.2, *)
class ViewController: NSViewController {

    @IBOutlet var skView: TouchoutView!

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
        print("making touchbar")

        guard let scene = skView.currentScene?.name else {
            return nil
        }

        let touchBar = NSTouchBar()
        touchBar.delegate = self
        switch scene {
        case "MenuScene":
            touchBar.customizationIdentifier = .menuBar
            touchBar.defaultItemIdentifiers = [.titleSpan, .menuStartBtn]
            touchBar.customizationAllowedItemIdentifiers = [.titleSpan, .menuStartBtn]
            touchBar.principalItemIdentifier = .menuStartBtn
        case "GameScene":
            touchBar.customizationIdentifier = .gameBar
            touchBar.defaultItemIdentifiers = [.titleSpan, .gamePaddleSlider]
            touchBar.customizationAllowedItemIdentifiers = [.titleSpan, .gamePaddleSlider]
            touchBar.principalItemIdentifier = .gamePaddleSlider
        default:
            return nil
        }

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
            item.view = NSButton(title: "Start", target: skView.menuScene, action: #selector(MenuScene.handleStartBtnOnTouch))
            return item
        case NSTouchBarItemIdentifier.gamePaddleSlider:
            // TODO style
            let item = NSSliderTouchBarItem(identifier: identifier)
            let slider = NSSlider(target: nil, action: nil)
//            let slider = NSSlider(target: skView.gameScene, action: #selector(GameScene.handleSliderOnTouch))
            slider.isContinuous = true
            item.slider = slider
            item.label = "slider"
            item.target = skView.gameScene
            item.action = #selector(GameScene.handleSliderOnTouch)
            return item
        default:
            return nil
        }
    }

}
