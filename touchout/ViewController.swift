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

            let menuScene = TouchoutScene(fileNamed: "MenuScene")!
            menuScene.scaleMode = .aspectFit
            view.switchScene(scene: menuScene, transition: nil)
        }
    }
}

@available(OSX 10.12.2, *)
extension ViewController: NSTouchBarDelegate {
    override func makeTouchBar() -> NSTouchBar? {
        guard let scene = skView.currentScene else {
            return nil
        }

        return scene.buildTouchBar()
    }
}
