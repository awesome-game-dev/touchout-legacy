import SpriteKit

@available(OSX 10.12.2, *)
protocol TouchoutSceneTouchbarable {
  func buildTouchBar() -> NSTouchBar
}

@available(OSX 10.12.2, *)
class TouchoutScene : SKScene, NSTouchBarDelegate {
}

@available(OSX 10.12.2, *)
extension TouchoutScene : TouchoutSceneTouchbarable {
  func buildTouchBar() -> NSTouchBar {
    return NSTouchBar()
  }
}
