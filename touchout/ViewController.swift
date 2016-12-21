//
//  ViewController.swift
//  touchout
//
//  Created by Nano WANG on 12/19/16.
//  Copyright © 2016 Nano WANG. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

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
