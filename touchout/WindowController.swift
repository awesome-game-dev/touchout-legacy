import Cocoa

class WindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        if let viewController = contentViewController as? ViewController {
            return viewController.makeTouchBar()
        } else {
            return nil
        }
    }
}
