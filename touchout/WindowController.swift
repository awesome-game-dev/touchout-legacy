import Cocoa

class WindowController: NSWindowController {
  override func windowDidLoad() {
    super.windowDidLoad()

    // zoom to max
    if let screen = NSScreen.main() {
      self.window!.setFrame(screen.visibleFrame, display: true, animate: true)
    }

    // bring to front at launch
    NSApp.activate(ignoringOtherApps: true)
  }
}

//
//extension WindowController : NSWindowDelegate {
//  
//}
